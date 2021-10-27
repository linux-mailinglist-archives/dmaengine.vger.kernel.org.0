Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954EB43C56A
	for <lists+dmaengine@lfdr.de>; Wed, 27 Oct 2021 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbhJ0IrX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Oct 2021 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbhJ0IrT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Oct 2021 04:47:19 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF235C061570;
        Wed, 27 Oct 2021 01:44:53 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id l13so4587457lfg.6;
        Wed, 27 Oct 2021 01:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=zMWK8hvpGJbXGsvO9RmIPb4Vp8Zoi5fIPTWz4fMTBMw=;
        b=lbp34rNa/A5IA66pNvQbVeLii9gDFaqxoc8T1ixMhEQ9u0s6rc9lz5UznqFulj10j9
         3HjPSYEC3cLm01QHECPUwJU3i7J5jXygj4E8S7xOFxgloAeqCYOl6GbXYHEhdYYtMV8v
         8NgMv3vE658xpSc1jtV+UY/jU8Wx5F++mGGHh74Emr1qyy7LO+0j8w0vQBBwHDiQ8LKx
         CrTibSTE3yvkc7H1qFQIn6mYmQUKRdIQTlaA0XdVP8GFD7tGW2wLCDndW2QyitVDB8VQ
         uN2jWh1VBHNWr/7EP+sx28ZxiR5ARAG2G/nAlnkf0x1++0qFIEEV8kzFFiH6Fo5oBWjN
         cJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=zMWK8hvpGJbXGsvO9RmIPb4Vp8Zoi5fIPTWz4fMTBMw=;
        b=VyIECKDXWhEhBwpCzEWJWteTb0OIlVHspAJoIrUL1CXiMRBJvD4u+DSmCS5qzS+LXG
         mkfl0bDWasxWmboPiHdocjn/aw9kIkzjHrw9yoM4Wm+4q0bx66Hpsgo9NbyYscd6M82L
         MoL+tmZep9OJjldNeiD6SRNLdweiifb9Ms/uQg22Mx/T3wPNXdbd0ZwJaUnwxBXJc8nY
         /CRq8X/oI8DT1uZKgnUrgBq2nhr4+FAQI9Hty5T4ab/JG2mLhgIsCOtwn/Ei1e2CH7BM
         orfrQoLF4kJ/vjD5Ig2OkMPlc1KfjgD6TB3/pUCoRCPcjK+5G0sZf/cgKh4MmSR5WVv7
         woIA==
X-Gm-Message-State: AOAM533yqE4bOKYU/v2WFCPlC/TyVv7t6IVoesJ6b0mJwzOnkhTuvTTF
        TGQ+F9Ir6Jf84mGScc6OyXkubJuHcE+q3g==
X-Google-Smtp-Source: ABdhPJyolc92grZUbacq8NFy/dsIGCz8Kges8hMolhaRfnor8WtDO4jgVL1W8bGkP3K22LfHLBuHnA==
X-Received: by 2002:ac2:5ed9:: with SMTP id d25mr4652910lfq.197.1635324292149;
        Wed, 27 Oct 2021 01:44:52 -0700 (PDT)
Received: from [10.0.0.115] (91-155-111-71.elisa-laajakaista.fi. [91.155.111.71])
        by smtp.gmail.com with ESMTPSA id d12sm793838lft.214.2021.10.27.01.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 01:44:51 -0700 (PDT)
Message-ID: <3d825723-6bed-75e0-492b-a9ec1c9e4994@gmail.com>
Date:   Wed, 27 Oct 2021 11:45:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <20211027055625.11150-1-kishon@ti.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Subject: Re: [RESEND PATCH v2 0/2] dmaengine: ti: k3-udma: Fix NULL pointer
 dereference error
In-Reply-To: <20211027055625.11150-1-kishon@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kishon,

On 27/10/2021 08:56, Kishon Vijay Abraham I wrote:
> NULL pointer de-reference error was observed when all the PCIe endpoint
> functions (22 function in J721E) request a DMA channel. The issue was
> specfically observed in BCDMA (Block copy DMA) but the issue is
> applicable in PKTDMA as well.

Nice catch, interesting that it did not materialized before.

Can you re-word the patch subjects and commit messages accordingly?

This is not really BCDMA/PKTDMA issue but a missed uc->Xchan = NULL;
which would cause the de-reference error.

> Changes from v1:
> 1) Split the patch for BCDMA and PKTDMA separately
> 2) Fixed the return value of udma_get_rflow() to 0.
> 3) Removed the fixes tag as the patches does not directly apply to the
> commits.
> 
> v1 => https://lore.kernel.org/r/20210209090036.30832-1-kishon@ti.com
> 
> Kishon Vijay Abraham I (2):
>   dmaengine: ti: k3-udma: Fix NULL pointer dereference error for BCDMA

dmaengine: ti: k3-udma: Set bchan to NULL if a channel request fail

>   dmaengine: ti: k3-udma: Fix NULL pointer dereference error for PKTDMA

dmaengine: ti: k3-udma: Set rchan/tchan to NULL if a channel request fail

This is also applicable for UDMA which only have rchan and tchan.

> 
>  drivers/dma/ti/k3-udma.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 

-- 
Péter
