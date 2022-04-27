Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B79511D17
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbiD0QDj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 12:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241571AbiD0QDX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 12:03:23 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 44635170E33;
        Wed, 27 Apr 2022 08:59:35 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6DA7720E97CA;
        Wed, 27 Apr 2022 08:58:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6DA7720E97CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651075134;
        bh=LOLk8KFWAb5rXU/Jm0ZFnROrkWq5xdzno1Ze707Mg8Q=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=lCin7lh3eOWoC8NOgWTsOU0C03Zh/WxRxATeRAsLc9arDLmXdbC8Xz3cFZXKGqkcf
         DfBeM6nu6FeQm0CloG/1lp+Jr4MIPORFywV2OmiQ61fJFZoc5aJpPjVsFbvFPSlF4R
         uU8SBBkMZMrfVfX7uVGZLvABbGZFb3L5JMNn+Qfs=
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <e8cb3d63-f5b9-d067-af66-86f7a7c7f76c@intel.com>
Date:   Wed, 27 Apr 2022 08:58:52 -0700
Cc:     Vinod Koul <vkoul@kernel.org>, olivier.dautricourt@orolia.com,
        sr@denx.de, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, ludovic.desroches@microchip.com,
        tudor.ambarus@microchip.com, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, nsaenz@kernel.org,
        paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com,
        gustavo.pimentel@synopsys.com, vireshk@kernel.org,
        andriy.shevchenko@linux.intel.com, leoyang.li@nxp.com,
        zw@zh-kernel.org, wangzhou1@hisilicon.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, sean.wang@mediatek.com,
        matthias.bgg@gmail.com, afaerber@suse.de, mani@kernel.org,
        logang@deltatee.com, sanju.mehta@amd.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        agross@kernel.org, bjorn.andersson@linaro.org,
        krzysztof.kozlowski@linaro.org, green.wan@sifive.com,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        patrice.chotard@foss.st.com, linus.walleij@linaro.org,
        wens@csie.org, jernej.skrabec@gmail.com, samuel@sholland.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <27B51CB8-FCC0-49FB-AA28-93594943423E@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <YmiuUy+PAjKEq6uE@matsya>
 <e8cb3d63-f5b9-d067-af66-86f7a7c7f76c@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


>> On 19-04-22, 21:16, Allen Pais wrote:
>>> The tasklet is an old API which will be deprecated, workqueue API
>>> cab be used instead of them.
>> What is the reason for tasklet removal, I am not sure old is a reason =
to
>> remove an API...
>>=20
>>> This patch replaces the tasklet usage in drivers/dma/* with a
>>> simple work.
>> Dmaengines need very high throughput, one of the reasons in dmaengine
>> API design to use tasklet was higher priority given to them. Will the
>> workqueue allow that...?
>=20
> Wouldn't the logical move be to convert threaded irq IF tasklets are =
being deprecated rather than using workqueue as replacement?

  Logically yes. Would all tasklets need to be moved to threaded irq, =
that I am not sure. I think
Workqueues does the job.

>=20
> Also, wouldn't all the spin_lock_bh() calls need to be changed to =
spin_lock_irqsave() now? Probably not as simple as just replace tasklet =
with workqueue.
>=20

Yes, this was carefully looked at as we have moved from the =
interrupt/softirq context to process context.

Thanks.

