Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D258438ED6
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhJYFdN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJYFdN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:33:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8385B60F6F;
        Mon, 25 Oct 2021 05:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635139851;
        bh=0zUBc23HyYEHAsnTwLjedoqcozwBGy9PK3ij1Knmw3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CL90s4lUF/aEpz03Ncgu1AZPG9iTkwpvAVBYEBH+fzqUUPVQq5H3iOpxvBkzvEa5/
         dw0klL0yilMsBVxF1Z0A/w7w+3Za2Mt7h60NONBAb11aJKfcgQ+TbFNbx5DRODDajB
         JF/H9RPzXOPnsOcpau2TPujkw2dbnQ4GGJpIr2/m+5j+HEufc76gyN0y0vuJ8m0Cvk
         7S7H7L2a6VdhVXdBWMygFA7mff4kY+vzd0eVgNEVyhaYqifUn6VHr4i14ACQb5jIh+
         huFNHQf5yzhRi53GJI5/uXPoTisRvWxkAprohEAR6Q+mKHVzHGyWkwmwraWN3sq9xY
         ScXYa5KCK7/mQ==
Date:   Mon, 25 Oct 2021 11:00:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove kernel wq type set when load
 configuration
Message-ID: <YXZBB7OZZBiYkc0h@matsya>
References: <163474724511.2607444.1876715711451990426.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163474724511.2607444.1876715711451990426.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-21, 09:27, Dave Jiang wrote:
> Remove setting of wq type on guest kernel during configuration load on RO
> device config. The user will set the kernel wq type and this setting based
> on config is not necessary.

Applied, thanks

-- 
~Vinod
