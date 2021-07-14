Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8943C7ED8
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jul 2021 08:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238140AbhGNHBd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 14 Jul 2021 03:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237948AbhGNHBd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 14 Jul 2021 03:01:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2CC36100C;
        Wed, 14 Jul 2021 06:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626245922;
        bh=t729mBrudEAT3IxucJe9qsUZkB5UMjg67WsVHY8OZ08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mp5DeZZohidjJ9fEQ1z4pb0XZpQ9xY0oD2yjKymkt3RhSR+d0AbxQEd5ZEDK0bq+H
         MRwQaiHOJsi7Zlojsbr2L3Lcs3XpvrOcRFczXXmuwV5r1p5NbEm52uedfVoBFaM9/l
         FOHEpTNHI4P4PY+6QA6Cpqq3PrnoJPykjGFfQ4vTdGtbmMQ8QdT4ignAhhXEc+CEIF
         rMdi1uKyrA7sItsOirx1BSdjIigCLTOji2S22euHyOsdg0p5ltDrsTCqwPLyrvN4B/
         MbW3BU45QeIN0NGWmMYgNNVnIX7SKiYZcXywKGvQC19XcJnphK2KHVhQvUn5LGjvBN
         tk2uk1AyWjcKA==
Date:   Wed, 14 Jul 2021 12:28:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Konstantin Ananyev <konstantin.ananyev@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: assign MSIX vectors to each WQ rather
 than roundrobin
Message-ID: <YO6LHpP3fCTpZ52M@matsya>
References: <162456717326.1130457.15258077196523268356.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162456717326.1130457.15258077196523268356.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-21, 13:39, Dave Jiang wrote:
> IOPS increased when changing MSIX vector to per WQ from roundrobin.
> Allows descriptor to be completed by the submitter improves caching
> locality.

Applied, thanks

-- 
~Vinod
