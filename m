Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4223F776F
	for <lists+dmaengine@lfdr.de>; Wed, 25 Aug 2021 16:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241488AbhHYOdI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Aug 2021 10:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241379AbhHYOdI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 25 Aug 2021 10:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C66A610C7;
        Wed, 25 Aug 2021 14:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629901942;
        bh=ZF7rvnNgNU4ktDqZEiJblxdPxr1L2Wok/qHEDFtokss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkC/sLxz0rzlnTbPGE0xLEbV/FkC+Zkx0DIabr970q3f24w6D4yMT/l8oayyVK9DY
         3OryYhzcpkQsEjgy7hurQBnsE+OkEs3HZmbFbSjvfz8GOnvvX6VwPForFOf50rdiyr
         0nZUEy2gVSUi9bmxENtolZ6/J80Paq9FulseVqH6FDwN23XNcCFbdnNUyYWQiZAgYO
         1/CmEtXRwYzqtZStWDBAoFAMOX74i7i6/bZMnrjoi9X6WNPCPl45BzgTHJhA0+oO8k
         k5DDi6LO46cLgc2Yz7bxy6kDtoz8AAn9eisHHrZdtSYeHk1EHqnA6PlF+eSZK14KrA
         cn6fjd9WtE+kg==
Date:   Wed, 25 Aug 2021 20:02:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chris Brandt <chris.brandt@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 0/3] Add RZ/G2L DMAC support
Message-ID: <YSZUcanmMRPG7ODQ@matsya>
References: <20210806095322.2326-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095322.2326-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-08-21, 10:53, Biju Das wrote:
> This patch series aims to add DMAC support on RZ/G2L SoC's.
> 
> It is based on the work done by Chris Brandt for RZ/A DMA driver.

Applied all after fixing the subsystem tag for patch 3!

-- 
~Vinod
