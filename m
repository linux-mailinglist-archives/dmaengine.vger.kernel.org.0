Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6969E918
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 21:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjBUUqD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Feb 2023 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBUUqC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Feb 2023 15:46:02 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 457802E811;
        Tue, 21 Feb 2023 12:45:59 -0800 (PST)
Received: from [192.168.42.220] (host-178-72-203-11.ip.nej.cz [178.72.203.11])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 02960A433;
        Tue, 21 Feb 2023 21:45:56 +0100 (CET)
Message-ID: <0f1aafa2-7495-163b-523a-f634bacc4b1f@gpxsee.org>
Date:   Tue, 21 Feb 2023 21:46:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RESEND PATCH V12 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Lizhi Hou <lizhi.hou@amd.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, larry.liu@amd.com, brian.xu@amd.com
References: <1675969514-3137-1-git-send-email-lizhi.hou@amd.com>
 <1675969514-3137-2-git-send-email-lizhi.hou@amd.com>
 <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <CAMuHMdXsUPAW5zKrsaTR9Tgv7kFdkz8s_QUjLXq6zDpoo47fRA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21. 02. 23 14:25, Geert Uytterhoeven wrote:

> No platform dependencies at all, while this is a platform driver that
> relies on some other not-yet-existing driver creating an "xdma"
> platform device?

There is at least one "already-existing" driver based on this driver 
that is waiting in the v4l2 queue for xdma - our MGB4 driver:
https://patchwork.kernel.org/project/linux-media/patch/20230207150119.5542-2-tumic@gpxsee.org/

And I'm quiet sure that more are to come when the xdma driver becomes 
finally available as the FPGA IP core is used in many more PCIe cards.

M.
