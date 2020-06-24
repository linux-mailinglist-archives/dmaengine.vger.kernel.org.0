Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59FE206C4B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 08:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388834AbgFXGXd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 02:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388090AbgFXGXd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 02:23:33 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A35A620768;
        Wed, 24 Jun 2020 06:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592979812;
        bh=Thk+QASiH8AqFU8njxc4TITHVyi5D8FjMZI13r9vx+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qR3aKouOHwk5wVJIrsC6SVOFXiljercGxJL/DwdW16SHudGIxJ4owO8WyLNQktvE
         X0aEgRcptpFfUnT+KKHY2J3XHLnxI/xOKJ4Gyv1st0z/MK46gHI7Rp0xYvATYQthD2
         lXwXna5Q4YMM2dga1ogF8Mi6YR4BUs8J8hAPmVic=
Date:   Wed, 24 Jun 2020 11:53:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, mona.hossain@intel.com
Subject: Re: [PATCH] dmaengine: idxd: fix hw descriptor fields for delta
 record
Message-ID: <20200624062328.GG2324254@vkoul-mobl>
References: <159120526866.65385.536565786678052944.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159120526866.65385.536565786678052944.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-06-20, 10:27, Dave Jiang wrote:
> Fix the hw descriptor fields for delta record in user exported idxd.h
> header. Missing the "expected result mask" field.
> 
> Reproted-by: Mona Hossain <mona.hossain@intel.com>

/sReproted-by/Reported

Applied with fix!

-- 
~Vinod
