Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A8722E88A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 11:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgG0JIS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 05:08:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbgG0JIS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 05:08:18 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0232320714;
        Mon, 27 Jul 2020 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595840897;
        bh=cKjSFajTMTVIbHiGmbvp/knDuFdf5FSpOZEQq8ErUYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L/otVaVkqNLzwix6OOCOALaDlCkcUVuasQYn6UFNy02/7vt4FE3rB6Y90BmJ1nMQd
         fB8Y3TWoyl/FmI/pJ7Q9F6nvxoo/sLpDB1TcXsQ4ILoBvGMMTaGk0c0dA0fQqt44P1
         K4XZ2YT9KOsYfGTqjnkf5Nkt6PtmRqyV5Us4hwtE=
Date:   Mon, 27 Jul 2020 14:38:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add missing invalid flags field to
 completion
Message-ID: <20200727090814.GO12965@vkoul-mobl>
References: <159526025819.49266.13176787210106133664.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159526025819.49266.13176787210106133664.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-20, 08:50, Dave Jiang wrote:
> Add missing "invalid flags" field to completion record struct.

Applied, thanks

-- 
~Vinod
