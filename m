Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753533D884A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 08:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbhG1Gyd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 02:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229939AbhG1Gyc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 02:54:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E59CB60F6D;
        Wed, 28 Jul 2021 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627455271;
        bh=MUYV0jG/ERmQtuox6LweFr8+A2D3sFP9Wy/d49bVa9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tb1BeW2kP47Po9LG2m56LlnWgbwntinZ2CESWupylKM3VooppvH9XlGVQVrEOV2dF
         zAkBGpXHQ3IjeeQBjAVPsEs4O+yjrrUtjyQPZ/K01fOPYVWgYC1GuVRhiZeV5d4Xw6
         kB0lxfKoGjYkn+AqXVjZnX/eHiJu1LGQFw87zrI2rpBCGqu12pI0aQtvSVTtjFzPTN
         OPf8r5QLgcrkcKGvlWLXtbjigzj6A3QdEQZXLTLNKRT6/e4afKmXTMpRHJXumRQTEc
         kqeKHwLe3RFg76KCbVSqBJKfs7zg2oXPPYsltyxq26WL9mDifc8W5Q6R2NspKgqDh2
         m+YR8Vg37mFOQ==
Date:   Wed, 28 Jul 2021 12:24:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stefan Roese <sr@denx.de>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: altera-msgdma: make response port optional
Message-ID: <YQD/IecbSJFVWQzo@matsya>
References: <cover.1623898678.git.olivier.dautricourt@orolia.com>
 <8220756f2191ca08cb21702252d1f2d4f753a7f5.1623898678.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8220756f2191ca08cb21702252d1f2d4f753a7f5.1623898678.git.olivier.dautricourt@orolia.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-06-21, 21:53, Olivier Dautricourt wrote:
> The response slave port can be disabled in some configuration [1] and
> csr + MSGDMA_CSR_RESP_FILL_LEVEL will be 0 even if transfer has suceeded.
> We have to only rely on the interrupts in that scenario.
> This was tested on cyclone V with the controller resp port disabled.
> 
> [1] https://www.intel.com/content/www/us/en/programmable/documentation/sfo1400787952932.html
> 30.3.1.2
> 30.3.1.3
> 30.5.5
> 
> Fixes:
> https://forum.rocketboards.org/t/ip-msgdma-linux-driver/1919

This should be single line, fixed it up while applying the series

-- 
~Vinod
