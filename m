Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED0A51202F
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiD0PsD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 11:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbiD0PsC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 11:48:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914CD4EA30;
        Wed, 27 Apr 2022 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651074287; x=1682610287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VeXWrrau3UGYgT+PE4NxfpOWIgpbbEl5MsiQ9g95Uas=;
  b=RDm++GYGo3zeL/S+3XOTfVA3GZGVgz3OI9fwiyoeyfQ1UEddFCEQmEHH
   lywUQcBy5pdO0hd1K8GnBwkIFM6ITHPK27o1h2lQR4yUCLi141/2Iuny4
   dPerzjxzcQpgl554653PHRlKZiky3cz3jvtqCih/U1Hgh/VckzL5Np3Qz
   KZsqrzKiinhdPyTX7pnN7vlXqIa+SRdR2Di14xVQpDhBGcpv68p0LOosJ
   8jBx7Y098Y8VdzMqi/SvTxqxIBidzIE53d29pzaaC4fp4tyA012sOESmx
   9znifIGvtcs2hV9U8GRO7zeBSfANA9q2BTuo+k5s7nGTCLr/DYiFIMZ/R
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="352403846"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="352403846"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:20:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="705592999"
Received: from eaojeh-mobl1.amr.corp.intel.com (HELO [10.212.22.124]) ([10.212.22.124])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:20:12 -0700
Message-ID: <e8cb3d63-f5b9-d067-af66-86f7a7c7f76c@intel.com>
Date:   Wed, 27 Apr 2022 08:20:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFC 1/1] drivers/dma/*: replace tasklets with workqueue
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>,
        Allen Pais <apais@linux.microsoft.com>
Cc:     olivier.dautricourt@orolia.com, sr@denx.de, keescook@chromium.org,
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
References: <20220419211658.11403-1-apais@linux.microsoft.com>
 <20220419211658.11403-2-apais@linux.microsoft.com> <YmiuUy+PAjKEq6uE@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YmiuUy+PAjKEq6uE@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 4/26/2022 7:45 PM, Vinod Koul wrote:
> On 19-04-22, 21:16, Allen Pais wrote:
>> The tasklet is an old API which will be deprecated, workqueue API
>> cab be used instead of them.
> What is the reason for tasklet removal, I am not sure old is a reason to
> remove an API...
>
>> This patch replaces the tasklet usage in drivers/dma/* with a
>> simple work.
> Dmaengines need very high throughput, one of the reasons in dmaengine
> API design to use tasklet was higher priority given to them. Will the
> workqueue allow that...?

Wouldn't the logical move be to convert threaded irq IF tasklets are 
being deprecated rather than using workqueue as replacement?

Also, wouldn't all the spin_lock_bh() calls need to be changed to 
spin_lock_irqsave() now? Probably not as simple as just replace tasklet 
with workqueue.


