Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C9F206DCB
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389704AbgFXHbe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388375AbgFXHbd (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:31:33 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF4B82073E;
        Wed, 24 Jun 2020 07:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592983893;
        bh=0xWayXOUt2a1I4aHu5ArPRZPxHVapGmtm1ta44ms2fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w/sNy0IIF7bPohSvw6nvwonKzlP8hmWzuTX3CRmtq01X9BGuGNiFwBxtZu8ko7L1H
         HpcOabZX6qKgnJS+nVjqaDmB6LeGbtttOLSr7fleXr9CCDZqEKrEkB4UxIm9WOjWQr
         GI+bRCMWMmY60p7XzP06IbsM9KZiDTpZDoWbzlMI=
Date:   Wed, 24 Jun 2020 13:01:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, yixin.zhang@intel.com
Subject: Re: [PATCH] dmaengine: idxd: cleanup workqueue config after disabling
Message-ID: <20200624073129.GM2324254@vkoul-mobl>
References: <158957065768.11894.4009779253452766084.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158957065768.11894.4009779253452766084.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-20, 12:24, Dave Jiang wrote:
> After disabling a device, we should clean up the internal state for
> the wqs and zero out the configuration registers. Without doing so can cause
> issues when the user reprogram the wqs.

Doesnt apply, pls rebase and resend

-- 
~Vinod
