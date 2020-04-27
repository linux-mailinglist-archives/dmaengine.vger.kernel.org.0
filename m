Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935921BA95F
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2020 17:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgD0P5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Apr 2020 11:57:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:33932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbgD0P5J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Apr 2020 11:57:09 -0400
Received: from localhost (unknown [171.76.79.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4CB8206D9;
        Mon, 27 Apr 2020 15:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588003028;
        bh=Hw1WZJTRPdURJ1ttqfh/6FE0gZHzdGZsD8awkVvLvrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CSOulQCzrKFXJu4DNwSBePUDeJ+pIvElN7UaqUU10ESqpQ76PAA5IQ6T3uiEpNYf2
         kVnX4YrXqrZJWYYOlYA2n8nSHVPK/Im0NZ0eKH0DzDWyl0opvIZ1IljtEiliyImp1y
         A7Y3NARYOalJRmChPIDhJhmI9nVdVbBY7b4trTc0=
Date:   Mon, 27 Apr 2020 21:27:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: fix channel index enumeration
Message-ID: <20200427155702.GE56386@vkoul-mobl.Dlink>
References: <158679961260.7674.8485924270472851852.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158679961260.7674.8485924270472851852.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-04-20, 10:40, Dave Jiang wrote:
> When the channel register code was changed to allow hotplug operations,
> dynamic indexing wasn't taken into account. When channels are randomly
> plugged and unplugged out of order, the serial indexing breaks. Convert
> channel indexing to using IDA tracking in order to allow dynamic
> assignment. The previous code does not cause any regression bug for
> existing channel allocation besides idxd driver since the hotplug usage
> case is only used by idxd at this point.
> 
> With this change, the chan->idr_ref is also not needed any longer. We can
> have a device with no channels registered due to hot plug. The channel
> device release code no longer should attempt to free the dma device id on
> the last channel release.

Applied, thanks

-- 
~Vinod
