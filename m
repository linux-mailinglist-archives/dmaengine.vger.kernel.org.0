Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904983A76DB
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jun 2021 08:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFOGIw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Jun 2021 02:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhFOGIw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 15 Jun 2021 02:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABE996109E;
        Tue, 15 Jun 2021 06:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623737208;
        bh=MpmsCBWcltC7Z41R4ZBLvQ1UF4QXF8v/fU2nHODL1P0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cd3TvAY4OhbYr1qccpe3ZqZYT9btNWpkCUgx+7jdGbjaCu3OLGHOl84AlBbfuuM0g
         vn8bK2wxU+seJnyvWuUmce8g0W9hMCpYsJ9qP4WRyLs9jNYP8CNvX+t46woJwI9xMT
         3xz2SJQ9jkWxvjTVSa72l6q8YG2rhrMhsooyXQzbJxKhDq0H/DMG6gR18rspJJE1zt
         xKhdzy6iBwoX6O1GPVFkgcKVJYywbyHCZDsm7cl/3bn2BJv2xvtDMWUGmP5pbY975R
         PDqNjlh7bMCbgrH/m+TQp+uUX9lJALhG7G/tHiJFBo9x5Qewfa5T35dmXJhnyZbx0J
         kyGgUXxcUAyoA==
Date:   Tue, 15 Jun 2021 11:36:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, robh+dt@kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org,
        festevam@gmail.com, s.hauer@pengutronix.de,
        martin.fuzzey@flowbird.group, u.kleine-koenig@pengutronix.de,
        dan.j.williams@intel.com, matthias.schiffer@ew.tq-group.com,
        frieder.schrempf@kontron.de, m.felsch@pengutronix.de,
        xiaoning.wang@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v14 12/12] dmaengine: imx-sdma: add terminated list for
 freed descriptor in worker
Message-ID: <YMhDdXnZlELhG16P@vkoul-mobl>
References: <1617809456-17693-1-git-send-email-yibin.gong@nxp.com>
 <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617809456-17693-13-git-send-email-yibin.gong@nxp.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-04-21, 23:30, Robin Gong wrote:
> Add terminated list for keeping descriptor so that it could be freed in
> worker without any potential involving next descriptor raised up before
> this descriptor freed, because vchan_get_all_descriptors get all
> descriptors including the last terminated descriptor and the next
> descriptor, hence, the next descriptor maybe freed unexpectly when it's
> done in worker without this patch.
> https://www.spinics.net/lists/dmaengine/msg23367.html

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
