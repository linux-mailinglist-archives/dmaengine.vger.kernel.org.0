Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DA379084
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhEJOVn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 10:21:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242828AbhEJOT3 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 10:19:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DBA560FF2;
        Mon, 10 May 2021 14:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620656305;
        bh=M3CT56AxKnRqByoRbuZgMWVNMz9YqMw+zfUM+yqswao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vc4JG+47kUfwYDP2WWLrMuFKieqTOsxqQhdQ6EEYk9v0wf0bGPTvpClF7VRCE5kei
         wzZ7oBcCL7yix9idrBZOKGkrpoovs69tobCaYAH5Xj/fNZkSiYv6yN1n0WzL8WgRXF
         bgehvgO4UUlUjx8rlBe6GvYJ5xRNrjq8la/wIXFBQrrt/drwUouYfixzTSsK2K6ZYQ
         09dFupGW0GwnowjPx9z6i3a6uZlSQWxJ3DLlK6F+IutPxTxctv3fA3ysTlIFru76Zg
         m0RH3tavxS1bk5mEOyrJoexx88ApvOyO5WF7H+3EFRA6w4uz4omUoUrbPIaq6OTZUB
         pQ8P2orQvtoYA==
Date:   Mon, 10 May 2021 19:48:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add engine 'struct device' missing bus
 type assignment
Message-ID: <YJlArWdMLly93N9J@vkoul-mobl.Dlink>
References: <161947841562.984844.17505646725993659651.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161947841562.984844.17505646725993659651.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-04-21, 16:09, Dave Jiang wrote:
> engine 'struct device' setup is missing assigning the bus type. Add it to
> dsa_bus_type.

Applied, thanks

-- 
~Vinod
