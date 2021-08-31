Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B933FCB59
	for <lists+dmaengine@lfdr.de>; Tue, 31 Aug 2021 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239862AbhHaQSz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Aug 2021 12:18:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239733AbhHaQSy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Aug 2021 12:18:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2873260FE8;
        Tue, 31 Aug 2021 16:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630426679;
        bh=ijFJRZX+OSPIfRRJIeek2KE83snf87M/UN9hXM4/RLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/zQRUOqGhiKgg5QOghl8C1mcnuhY+jCKDuSsfcDIJfzYDwqeugqNbB2NoE9TMcGF
         5TM7dyFEB56nqMTmzRfTDreKiTpIRE8X2OgEj5duwmwk8gD314HfZk7RnmwRXO29jk
         ouSZFojRP3qRLgoxM7/FujdTe4essyAcI/NufkehlMIlerHiPksttpgr3j0ym+/zLo
         LkVFjwAGKmB1QPLyt25mheY1M2BSP+LCTBGIv42APJo+Vg7FyLSskX1yeb/cWZ3Ut7
         xJNnObPl9s1xApIuOlMIvJlot7i5Q9YJhiBWMExPVvl1FI31lJyHTur5EsCHLiGbH2
         UKKOrSY/gCIuA==
Date:   Tue, 31 Aug 2021 21:47:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Sanjay R Mehta <sanju.mehta@amd.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Fix AMD PTDMA DRIVER entry
Message-ID: <YS5WMu4g1FMzoIRp@matsya>
References: <28b7663ebcaf9363324a615129417b24625a7038.1630413650.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b7663ebcaf9363324a615129417b24625a7038.1630413650.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-08-21, 14:42, Geert Uytterhoeven wrote:
> Remove the bogus leading plus signs from the entry for the AMD PTDMA
> driver.

Applied, thanks

-- 
~Vinod
