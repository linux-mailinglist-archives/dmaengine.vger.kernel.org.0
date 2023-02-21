Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6B969E9B2
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 22:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjBUVq2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 16:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjBUVq1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 16:46:27 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D2682E0C3;
        Tue, 21 Feb 2023 13:46:24 -0800 (PST)
Received: from [192.168.42.220] (host-178-72-203-11.ip.nej.cz [178.72.203.11])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 4BEE2A4F0;
        Tue, 21 Feb 2023 22:46:22 +0100 (CET)
Message-ID: <aeb43671-57fd-654a-8e8d-d14ebb7f4083@gpxsee.org>
Date:   Tue, 21 Feb 2023 22:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
 <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
 <0f1aafa2-7495-163b-523a-f634bacc4b1f@gpxsee.org>
 <CAMuHMdUVkbPf1a8cW+zY1HwD83tm_m0L7Ufy=GO-RQB-AF_15A@mail.gmail.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <CAMuHMdUVkbPf1a8cW+zY1HwD83tm_m0L7Ufy=GO-RQB-AF_15A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21. 02. 23 22:06, Geert Uytterhoeven wrote:
> Hi Martin,
> 
> On Tue, Feb 21, 2023 at 9:45 PM Martin Tůma <tumic@gpxsee.org> wrote:
>> On 21. 02. 23 14:25, Geert Uytterhoeven wrote:
>>> No platform dependencies at all, while this is a platform driver that
>>> relies on some other not-yet-existing driver creating an "xdma"
>>> platform device?
>>
>> There is at least one "already-existing" driver based on this driver
>> that is waiting in the v4l2 queue for xdma - our MGB4 driver:
>> https://patchwork.kernel.org/project/linux-media/patch/20230207150119.5542-2-tumic@gpxsee.org/
> 
> Thanks for the link!
> 
> As VIDEO_MGB4 selects XILINX_XDMA, perhaps XILINX_XDMA
> can be made invisible, unless compile-testing?
> 
>      config XILINX_XDMA
>          tristate "Xilinx DMA/Bridge Subsystem DMA Engine" if COMPILE_TEST
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 

Hi,
I think that the XDMA driver will always be used by a superior PCIe card 
driver like in our case (mgb4) and using it separately makes no sense/is 
not possible, so disabling it until some of the superior drivers selects 
it makes sense for me. But what about out-of-the-tree modules based on 
xdma? Making the module "invisible" will make compile them much harder I 
guess? And there will be proprietary drivers based on xdma, see Xilinx 
XRT: https://github.com/houlz0507/XRT-1/tree/xdma_v4_usage

The xdma authors from Xilinx will definitely give you a more 
authoritative answer. I'm just a "random" user of the xdma module. 
Originally our mgb4 driver was based on our own xdma sub-driver (in turn 
based on some old "test" driver from Xilinx) which I was glad we could 
abandon when this xdma driver has appeared. I helped the xdma module to 
become usable for PCIe cards like our v4l2 grabber, but the original 
intents of the xdma driver are unknown to me. If it is XRT, than Xilinx 
will probably like the module to stay visible.

M.

