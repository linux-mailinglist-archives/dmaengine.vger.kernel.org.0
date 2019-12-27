Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFD512B1C9
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 07:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbfL0Ggz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 01:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0Ggz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 01:36:55 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 361C0206CB;
        Fri, 27 Dec 2019 06:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577428615;
        bh=mE3nltBgHp37Je66Um1pNkFOMZDlzRuRm1sNDrawGrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=btCRaCJeivWLYTsZvL4KWn3lFQkB+yeZAMqjP9brIRaU75I6PGAujLrMssNVypOTX
         ZnXoxfadXuKiMfN3RdIaYli2MfZr0eJtPh7xrnrl7MUAsKo7xZJRpXYuoNFoM2dBNg
         u5uTeIwVxEc314uh00+nWLg5aDCGiLvs4KlONmKc=
Date:   Fri, 27 Dec 2019 12:06:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Alexander.Barabash@dell.com
Cc:     dmaengine@vger.kernel.org, alexander.barabash@gmail.com
Subject: Re: [PATCH v2] ioat: ioat_alloc_ring() failure handling.
Message-ID: <20191227063650.GH3006@vkoul-mobl>
References: <75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75e9c0e84c3345d693c606c64f8b9ab5@x13pwhopdag1307.AMER.DELL.COM>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-12-19, 17:55, Alexander.Barabash@dell.com wrote:
> If dma_alloc_coherent() returns NULL in ioat_alloc_ring(), ring
> allocation must not proceed.
> 
> Until now, if the first call to dma_alloc_coherent() in
> ioat_alloc_ring() returned NULL, the processing could proceed, failing
> with NULL-pointer dereferencing further down the line.

Applied, thanks

-- 
~Vinod
