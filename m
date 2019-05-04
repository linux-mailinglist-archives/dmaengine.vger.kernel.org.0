Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A47911395B
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2019 12:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfEDKoI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 4 May 2019 06:44:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbfEDKoI (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 4 May 2019 06:44:08 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57471206DF;
        Sat,  4 May 2019 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556966648;
        bh=JGWkOV/hj8H+O/TaeLZewNOAIluePPJyTL/Z+sEbtrc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R1/I7vGESntvEjsznnS5YSGrJEHFUUsl/HX7tDipbeSdMiEflWSxaLbl6HrrNSuQe
         wOyfDUGn52JKUfQxlBb5rr94/JCdQXupAjocbPBTs4KEblMN1VfEwuuvut+fJsgksQ
         +iffzYiqmarWuk5PjBCU0Qs1X9I3WtMvT/Zinvzo=
Date:   Sat, 4 May 2019 16:13:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, robh+dt@kernel.org, mark.rutland@arm.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        ldewangan@nvidia.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] Add support for Tegra186/Tegra194 and generic fixes
Message-ID: <20190504104359.GB3845@vkoul-mobl.Dlink>
References: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556801717-31507-1-git-send-email-spujar@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-05-19, 18:25, Sameer Pujar wrote:
> Audio DMA(ADMA) interface is a gateway in the AHUB for facilitating DMA
> transfers between memory and all of its clients. Currently the driver
> supports Tegra210 based platforms. This series adds support for Tegra186
> and Tegra194 based platforms and fixes few functional issues.

Applied all, thanks
-- 
~Vinod
