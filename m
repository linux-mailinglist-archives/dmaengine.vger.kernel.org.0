Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E221C438F51
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhJYGX7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:23:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhJYGX7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 02:23:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BBD9604DA;
        Mon, 25 Oct 2021 06:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635142897;
        bh=tczYKLAOjKUR0xPDoIaYQLFI9Zr1s7ZbZ3O+ROXj7fQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PARe3q8OoV9EsNIGwc86VLTrfSm9oCpHAqqQpSZGipf6xsakKTWCA1njS9PgQLHu3
         RFECnp/Y3Fb+3yd1LANGCNCjl1HRIE9v0wnXs6nHik2xLH3ouesBaJ5QTkIC9VPUfO
         4GNu+upcmWYQwNYI68iw9zHcMUk2IWwdD0NWSE6/6LU82m+AtNDyoWoPPyRB929m3m
         XLWFsuE8g+1JTmydRSwraS9RRMuHARWbFMHNS1R+TnJhBvdvV3MAU1IlnmOYd9PAuf
         lkaIDGoBDXZ02ay3BGNVDdhQFZ9lTo+EDJuCvWKFqYMguqexE3AKcN75xr/whHhFz1
         oRUaD2Seamhnw==
Date:   Mon, 25 Oct 2021 11:51:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ziye Yang <ziye.yang@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmanegine: idxd: fix resource free ordering on driver
 removal
Message-ID: <YXZM7UB4y857Crpy@matsya>
References: <163225535868.4152687.9318737776682088722.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163225535868.4152687.9318737776682088722.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-09-21, 13:15, Dave Jiang wrote:
> Fault triggers on ioread32() when pci driver unbind is envoked. The
> placement of idxd sub-driver removal causes the probing of the device mmio
> region after the mmio mapping being torn down. The driver needs the
> sub-drivers to be unbound but not release the idxd context until all
> shutdown activities has been done. Move the sub-driver unregistering up
> before the remove() calls shutdown(). But take a device ref on the
> idxd->conf_dev so that the memory does not get freed in ->release(). When
> all cleanup activities has been done, release the ref to allow the idxd
> memory to be freed.

Applied, thanks

-- 
~Vinod
