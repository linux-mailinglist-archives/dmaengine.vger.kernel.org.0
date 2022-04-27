Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA625511D80
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiD0P4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 11:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240434AbiD0P4p (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 11:56:45 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99A4064713;
        Wed, 27 Apr 2022 08:53:28 -0700 (PDT)
Received: from smtpclient.apple (d66-183-91-182.bchsia.telus.net [66.183.91.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7149C20E97B3;
        Wed, 27 Apr 2022 08:53:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7149C20E97B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1651074808;
        bh=TX9/CTz2WBo5vbbwED+TNm+pe6iYOqpcRxy113F+nEs=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
        b=ZKOzz9l2xv5aNTdWwZ4q+vZhDBP5yr52RLVoFAv88x9lQU9pCcPiUElU3QDN+lQOa
         RMu2HIPSGrrjv0rWaJOFGE1+w/vNAfqNI2CXXJDVQNTX1+Z7TW5jgaM7eRWJBVD2AW
         iucNZ1g853BVeBOYcJtm7owZqSHtapaLpQKQiArg=
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
From:   Allen Pais <apais@linux.microsoft.com>
In-Reply-To: <YmiuUy+PAjKEq6uE@matsya>
Date:   Wed, 27 Apr 2022 08:53:26 -0700
Cc:     olivier.dautricourt@orolia.com, sr@denx.de,
        Kees Cook <keescook@chromium.org>,
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
Message-Id: <2B3258A9-47BA-4AA3-A4E8-BE255D5F4506@linux.microsoft.com>
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <YmiuUy+PAjKEq6uE@matsya>
To:     Vinod Koul <vkoul@kernel.org>
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


>> The tasklet is an old API which will be deprecated, workqueue API
>> cab be used instead of them.
>=20
> What is the reason for tasklet removal, I am not sure old is a reason =
to
> remove an API...

 While we moved to modernised version of tasklet API, there was
A request to entirely remove tasklets. The following patch is an attempt
Towards it.=20

>=20
>>=20
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
>=20
> Dmaengines need very high throughput, one of the reasons in dmaengine
> API design to use tasklet was higher priority given to them. Will the
> workqueue allow that...?

  It is interesting that you brought up this point. I haven=E2=80=99t =
had the opportunity
To test the changes by stressing the kernel, what tests/benchmarks would
You prefer to see run on with these changes.

Thanks.

>=20
> --=20
> ~Vinod

