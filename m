Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE35484ED1
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jan 2022 08:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbiAEHmi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Jan 2022 02:42:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35848 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiAEHmh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Jan 2022 02:42:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F444B817C3
        for <dmaengine@vger.kernel.org>; Wed,  5 Jan 2022 07:42:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB6C36AE3;
        Wed,  5 Jan 2022 07:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641368555;
        bh=GoV+wouq6jEL/9QZxFJB51DJqpLzSAoNbk3Fn7m8+u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmZfT/PgJck5ZqmA7uoyKQJ+HJ0p68wG6n5GxmnLvbhTO1ivTO7toJ9t7bskCOizP
         9qBVqhznJHEV0FZu+yFUVkcTGXwuKOVJ0GNosFEyKMJsyfskucoO+FUNuCQCX0Dx1N
         X6eq+lni75LTRWfmrnRacpleiUDrdkLz5pWoHgkkX/dURHsSBLjbych12RYoJh7Gjz
         ovPr0Ux0fPhdNEU67U/g9hV+hNqKr1hAkggxPMlcsngfWpBH1KRBMdlzSgSQz4wQkh
         gSKbM7tnJsKo4WNwPHAnU/TF1w2ilAEyuDaGGRn5ul3rJzDUIenr/m4sT45hm/Ctn7
         qBbPMITNFo6cw==
Date:   Wed, 5 Jan 2022 13:12:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/3] refactor driver to only enable irq for wq enable
Message-ID: <YdVL54o5NZZz6uMX@matsya>
References: <163942143944.2412839.16850082171909136030.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163942143944.2412839.16850082171909136030.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-12-21, 11:51, Dave Jiang wrote:
> This patch series refactors the code to enable irq on wq enable only
> when necessary instead of allocation all msix vectors at probe. This saves
> CPU irq vector allocation on x86 platforms.

Applied, thanks

-- 
~Vinod
