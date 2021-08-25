Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74E3F7755
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 16:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhHYO12 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 10:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237860AbhHYO1Y (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 10:27:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0528360184;
        Wed, 25 Aug 2021 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629901599;
        bh=b+M7siFsJ0MC41QBMbYLM4b/m/yRMBUl03hhqa207Mg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJs9BY1+QfE62i0Xqj1dLZMJIPTKg05XrykJCaq7wi2VFO83atFgVFtaGxOYd5tB7
         usdKsMvT946bUbgH6q3qmiHUpCBM/i2vLU/kGa0huYYtuiPCvI7QQA4CdBvwtTXcfK
         TD6rMwBseffQ+fQw+1ssXber8TiCs+9/BYf0eLIuVo52u8o2R6l27xIbXpMzqkRXbV
         d4EIREoZozRhS9TQeT/FPoumBiakn3w1u94mmt1ofRAUuP1CrkCmwLMnG+JWazY8vv
         KPxQxE3DamPTh7TRVEFcndTuTkVrbf+0NT5af6BPFkFwGhlBsT6lGY9vr5VgLrAC9i
         PGs8ZfcCAOQbw==
Date:   Wed, 25 Aug 2021 19:56:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5] dmaengine: Loongson1: Add Loongson1 dmaengine driver
Message-ID: <YSZTGhBcSTFEPB4d@matsya>
References: <20210704153314.6995-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704153314.6995-1-keguang.zhang@gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-07-21, 23:33, Keguang Zhang wrote:
> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch adds DMA Engine driver for Loongson1B.

Applied, thanks

-- 
~Vinod
