Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866443FCB6B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Aug 2021 18:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239945AbhHaQVg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Aug 2021 12:21:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239936AbhHaQVg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Aug 2021 12:21:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D621610C9;
        Tue, 31 Aug 2021 16:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630426841;
        bh=gJo/PqZiB9eEvMdeme1iFavU7DahGL75B0SB6PykSwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YtChAsVEpfAv97Lg5Ig4bFjjmKI/BLbDW/VX35QQTiOKhIoEoIxhTBO7DolNgv+u8
         UUB78TdKAJ2Ow1kkr6+u13YJUDrWe7MgGL/C8l8QKRx8HVIgT+Ob+Aniv2xMb1B1Es
         ICJ18hl80MgRGgihVdTLsShr6o6a5EYYRyek6WKe54ARQkx80otQbptqrSDHBYxBuE
         QTrjnZUOf7gLdgWMLqDwVfdCzr6p/1u2EGEn8sfvFhckKc7C2P8FUyHOWvPY3B6dOo
         1ZeMol3+WX15e+30hx5niGXQx73J9u0GNzIXYLEWggoqZM5YUCmtw6w58m8RnpCW+D
         CDHHZ43PZHQxA==
Date:   Tue, 31 Aug 2021 21:50:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sh: fix some NULL dereferences
Message-ID: <YS5W1GYegSqqDXTJ@matsya>
References: <20210827085410.GA9183@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827085410.GA9183@kili>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-08-21, 11:54, Dan Carpenter wrote:
> The dma_free_coherent() function needs a valid device pointer or it will
> crash.

Applied, thanks

-- 
~Vinod
