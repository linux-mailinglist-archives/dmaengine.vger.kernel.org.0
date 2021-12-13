Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB8C4720E2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 07:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhLMGCU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 01:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhLMGCT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 01:02:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B05C061748;
        Sun, 12 Dec 2021 22:02:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3790AB80D1F;
        Mon, 13 Dec 2021 06:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18009C00446;
        Mon, 13 Dec 2021 06:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639375337;
        bh=ph5goTJMds46I3p7wgsridNAuEgW6rLlPVPgKZVmFS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIxfSGqAtIGpWzktmh4ZjuGdsNZ3enWQB5P+WsMv4W9z/8LkzDwMaxiBgIDNwMk1F
         jo+n3MAWAwjbHmz2hssrbt5+wHXMu2+EZjmW1peEqcMhsjSSBGeFtCMQPp2dKhRAFq
         S7osAybvMgaklmqtfOyUV1DY3i7UVqH4j9RjnmhHxR6MW16Bp9WmCuusmma4X11RZ+
         Ukyho0I9YBhtpW/cj2lFXyGbeHIveRL4VrIIMHIEX0IkfOI5As9BtHoK9NFfagAzd1
         7MUcj+35gKRDnIajKrL/Ecu/FDbrExQMbusjW+mbAaORCWADSg0OXkw92eiDXfQEM4
         nqAKl5ge9McbA==
Date:   Mon, 13 Dec 2021 11:32:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/2] J721S2: Add initial support
Message-ID: <Ybbh5BwCdezGjJkz@matsya>
References: <20211119132315.15901-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211119132315.15901-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-11-21, 18:53, Aswath Govindraju wrote:
> The following series of patches add support for J721S2 SoC.
> 
> Currently, the PSIL source and destination thread IDs for only a few of the
> IPs have been added. The remaning ones will be added as and when they are
> tested.
> 
> The following series of patches are dependent on,
> - http://lists.infradead.org/pipermail/linux-arm-kernel/2021-November/697574.html

Applied, thanks

-- 
~Vinod
