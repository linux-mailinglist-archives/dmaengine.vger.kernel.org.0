Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D735393EC6
	for <lists+dmaengine@lfdr.de>; Fri, 28 May 2021 10:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhE1Ibg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 May 2021 04:31:36 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50454 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1Ibg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 May 2021 04:31:36 -0400
Received: from [192.168.1.111] (91-157-208-71.elisa-laajakaista.fi [91.157.208.71])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1F66D8C7;
        Fri, 28 May 2021 10:29:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1622190600;
        bh=AU4smLRKI56chamFC/06ImQhk+wIOSduD/OW7VNLncE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SZTktZ9Lml3BMvsaf43+G20gQyBnl1hPRCHCKdZ1yA67HkxVNG41b9kNVEdQqBzcf
         g+uVx7zed9vbJJOF5WBr9em6KBXaAQq8w92LQ5xffceGC9G6jF7NqZUnIMv8yjx66R
         Ap4YNuqLyf7nYmuaPvIC6Dqo7DXbka5b7MJjotOQ=
Subject: Re: [PATCH v2 12/18] media: Re-structure TI platform drivers
To:     Pratyush Yadav <p.yadav@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Benoit Parrot <bparrot@ti.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, dmaengine@vger.kernel.org
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20210526152308.16525-1-p.yadav@ti.com>
 <20210526152308.16525-13-p.yadav@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Message-ID: <ab57c57f-d362-34a6-e740-b297769ee817@ideasonboard.com>
Date:   Fri, 28 May 2021 11:29:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526152308.16525-13-p.yadav@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26/05/2021 18:23, Pratyush Yadav wrote:
> The ti-vpe/ sub-directory does not only contain the VPE-specific things.
> It also contains the CAL driver, which is a completely different
> subsystem. This is also not a good place to add new drivers for other TI
> platforms since they will all get mixed up.
> 
> Separate the VPE and CAL parts into different sub-directories and rename
> the ti-vpe/ sub-directory to ti/. This is now the place where new TI
> platform drivers can be added.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> ---
> Compile tested only. There should be no functional change.

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

