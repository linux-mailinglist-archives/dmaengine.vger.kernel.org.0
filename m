Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E39167211E
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jan 2023 16:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjARPXl (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 18 Jan 2023 10:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjARPXW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 18 Jan 2023 10:23:22 -0500
Received: from mx.gpxsee.org (mx.gpxsee.org [37.205.14.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27CD423304;
        Wed, 18 Jan 2023 07:20:43 -0800 (PST)
Received: from [192.168.4.25] (unknown [62.77.71.229])
        by mx.gpxsee.org (Postfix) with ESMTPSA id 7E33B34B63;
        Wed, 18 Jan 2023 16:20:40 +0100 (CET)
Message-ID: <e2cc9724-1ac3-53c4-e33a-197262b989a2@gpxsee.org>
Date:   Wed, 18 Jan 2023 16:20:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH V11 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx
 xdma driver
To:     Vinod Koul <vkoul@kernel.org>, Lizhi Hou <lizhi.hou@amd.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        max.zhen@amd.com, sonal.santan@amd.com, larry.liu@amd.com,
        brian.xu@amd.com
References: <1673988842-43631-1-git-send-email-lizhi.hou@amd.com>
 <1673988842-43631-2-git-send-email-lizhi.hou@amd.com>
 <Y8eRhO0j+zozVL8N@matsya>
Content-Language: en-US
From:   =?UTF-8?Q?Martin_T=c5=afma?= <tumic@gpxsee.org>
In-Reply-To: <Y8eRhO0j+zozVL8N@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

>> +static struct platform_driver xdma_driver = {
>> +	.driver		= {
>> +		.name = "xdma",
>> +	},
>> +	.id_table	= xdma_id_table,
>> +	.probe		= xdma_probe,
>> +	.remove		= xdma_remove,
>> +};
>> +
>> +module_platform_driver(xdma_driver);
> 
> who creates this platform device? Any reason why this is not a _real_
> device?
>

The platform device is created by the PCIe card device/driver that uses 
XDMA. See for example our mgb4 v4l2 driver:
https://patchwork.kernel.org/project/linux-media/patch/20230113172636.2590-2-tumic@gpxsee.org/

M.
