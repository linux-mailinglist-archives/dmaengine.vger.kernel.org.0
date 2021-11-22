Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBC7458929
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 06:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhKVFyu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 00:54:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:50722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhKVFyt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Nov 2021 00:54:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0C46E60E0B;
        Mon, 22 Nov 2021 05:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637560303;
        bh=FO6Tvnmlhk4XGESvbWGf8qpLp3cUM9HlNv6nSDQ4nx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcnaccTOCUK+Y7NvX8gQi7r7j7VtLT+H45cULGUi9JizR37ZvS3Jk/MTlsFoW6Mj7
         3K2vjPk8BOUgEPPIImw1WryVmFyzgZnPihqgvlGkTKUSq98Asw1uzYIziDnG5P7U7D
         6STIrlDo1q3p205eaSAq6DzbmTVIJxS8dEIrM2bx9KXv8ng/0LvJkAnGYvj2tNFDov
         3gOhoL7uwFwIhrQzguMKPKD9rjCRbJLwsWkJTFti8Vu4K90o4Sc4IdTN2shUncLET/
         h4inSWJfb+0CkHiCUKpgTiFQnY/8N1d4e5vjzbaXn0iePVDOShsu6ghMQcBrZXrxEO
         f9Yq+tPtHVpPQ==
Date:   Mon, 22 Nov 2021 11:21:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: idxd: Add interrupt handle revoke
 support
Message-ID: <YZsv6og4TVQ7annH@matsya>
References: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-10-21, 14:35, Dave Jiang wrote:
> v2:
> - Fix comment header typo (Vinod)
> - Declare and init struct w/o memset (Vinod)
> 
> The series adds support to refresh the interrupt handles when they become
> invalid. Typically this happens during a VM live migration where a VM moves
> from one machine to another. The driver will receive an interrupt to
> indicate that interrupt handles need to be changed. The driver blocks the
> current submissions and acquires new interrupt handles. All submissions
> will be held off until the handle is refreshed. Already submitted
> descriptor
> will error with status of "incorrect interrupt handle" and be resubmitted
> by the
> driver.

Applied, thanks

-- 
~Vinod
