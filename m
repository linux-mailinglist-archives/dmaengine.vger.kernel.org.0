Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D302D797E
	for <lists+dmaengine@lfdr.de>; Fri, 11 Dec 2020 16:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbgLKPed (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Dec 2020 10:34:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgLKPe2 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 11 Dec 2020 10:34:28 -0500
Date:   Fri, 11 Dec 2020 19:46:09 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607696177;
        bh=DAaBOHLvMsSyw+6neqLESTSqSmL9MuEzW34NMZ1jC80=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZPbQybCU2On5nHF+ztIHW+5PMZxFAkUaSvSFw1jAuOAfrCJxTV1pIyXvEzXuVWur
         TtJrWcgSn4IdT5oE0QwDIsYTsBC+OM59YMYQhooKsPNfC21RRI1U9AyAHV6WxSXJbL
         7+N62l/cIbBly7E25gW1Hqc8JF7iuXgQXvVsAQyuQIKIrylRQjI2/V6XLdeuHK8hlX
         YVuaCt3h26rKOjRa5ZCDIeE3BPe4fxbPBT0hZrcN0mSF0VdRWqGhZDOzE+h4le17g6
         BbmxSQJyLskWiYA/D9W56RdEDZogro3D8P84F2YqD1UFLsp4uGiazvzeOPg7zO/lY0
         G7jJCLNTq12rQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, tony.luck@intel.com,
        dan.j.williams@intel.com
Subject: Re: [PATCH] dmaengine: idxd: add IAX configuration support in the
 IDXD driver
Message-ID: <20201211141609.GW8403@vkoul-mobl>
References: <160564555488.1834439.4261958859935360473.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160564555488.1834439.4261958859935360473.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-11-20, 13:39, Dave Jiang wrote:
> Add support to allow configuration of Intel Analytics Accelerator (IAX) in
> addition to the Intel Data Streaming Accelerator (DSA). The IAX hardware
> has the same configuration interface as DSA. The main difference
> is the type of operations it performs. We can support the DSA and
> IAX devices on the same driver with some tweaks.
> 
> IAX has a 64B completion record that needs to be 64B aligned, as opposed to
> a 32B completion record that is 32B aligned for DSA. IAX also does not
> support token management.

Applied, thanks

-- 
~Vinod
