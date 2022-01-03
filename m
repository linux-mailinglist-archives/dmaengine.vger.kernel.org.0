Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13C848307C
	for <lists+dmaengine@lfdr.de>; Mon,  3 Jan 2022 12:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiACL2i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Jan 2022 06:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiACL2i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Jan 2022 06:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4A1C061761;
        Mon,  3 Jan 2022 03:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16853B80E91;
        Mon,  3 Jan 2022 11:28:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E14EC36AE9;
        Mon,  3 Jan 2022 11:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641209315;
        bh=1vzwpzgBnfmSqhJYCuM/9d3Tit9k5yEiADQ4z9iQ0FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gp1/peMcaPgqQCv51/JFFxfUelTMC613VU38pylu2sC3O6x4+pesiKBYAYUR8dQ6c
         pmHXPkfMmMENy7lWBFfeFtkoIzP0Qhf1YGluKV27Cfc70B0pWZ9a4OQYyLXOdO2K6E
         LHbI7IzVdqVcPBV5oMvZ9LAq3E5GOyPnz1xUUxREfFnsIiBLb+5XhCNCfoc0tcyAse
         VeM2uE3fy8xf2y4Eo3tEtxqNgXHroXry45VYeeSmfbCyHAE05vcMGpuweqiq3lUnYL
         YG+OqMTIbHFFnt0+GZG76OH8S4YJbKrU9AbOq/PBSQRR79IZqgi/4hRFb8KUZQ+NMb
         5qZoAdGw6458A==
Date:   Mon, 3 Jan 2022 16:58:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     robh+dt@kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 0/2] dmaengine: rcar-dmac: Add support for R-Car S4-8
Message-ID: <YdLd30D+YOPMQD9z@matsya>
References: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211222114507.1252947-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-12-21, 20:45, Yoshihiro Shimoda wrote:
> This patch series adds support for rcar-dmac of R-Car S4-8.
> To use the rcar-dmac, we also need to enable the module clocks
> by the following patch:
> https://lore.kernel.org/all/20211221052423.597283-1-yoshihiro.shimoda.uh@renesas.com/

Applied, thanks

-- 
~Vinod
