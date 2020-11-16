Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA26F2B4C2B
	for <lists+dmaengine@lfdr.de>; Mon, 16 Nov 2020 18:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgKPRIf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Nov 2020 12:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbgKPRIe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Nov 2020 12:08:34 -0500
Received: from localhost (unknown [122.171.203.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2F1420E65;
        Mon, 16 Nov 2020 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605546514;
        bh=b2FiAgoNYswGmTuH8/E1hGoNb6lNZJ7MKOzIeng/MEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UC+fAjstrF9zfayRT1MEsh/C04sXAsO/vkl02ChLv6jCKsWkwAdYcVH5SHnjAPMhn
         hL63XkteQ5+o9p3dU3Top27tDPRWu/LDJTCQCw3zn/++D/hWK0lsi2peqC7Oud4Tk5
         dk3KR3F9kobBWFxH+9lSBpOheDngP3EY/xO5sJI4=
Date:   Mon, 16 Nov 2020 22:38:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: fix mapping of portal size
Message-ID: <20201116170830.GW7499@vkoul-mobl>
References: <160513342642.510187.16450549281618747065.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160513342642.510187.16450549281618747065.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-11-20, 15:23, Dave Jiang wrote:
> Portal size is 4k. Current code is mapping all 4 portals in a single chunk.
> Restrict the mapped portal size to a single portal to ensure that submission
> only goes to the intended portal address.

Applied, thanks

-- 
~Vinod
