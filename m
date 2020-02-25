Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5601F16B96F
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 07:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgBYGJm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 01:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgBYGJm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 01:09:42 -0500
Received: from localhost (unknown [122.167.120.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5DE20656;
        Tue, 25 Feb 2020 06:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582610982;
        bh=MgRBEVbXH6Six0fegMThof5UD5xrOEnaDVYeIeAhfiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vO+0B2B4v1T170HBoQEpBd7/e4TD/oAq7OTDhoC2hWax9zPCFAdyH44WsHbHG4X6F
         I95s17gC5URJG048oj0yBmD6x9QVK0vrp737UoIGF0JduUxOpi0M43V7FaudxSSXZC
         /thhjkZqukv0r7CgPYRcs0z1WvCruQG9XD2137H8=
Date:   Tue, 25 Feb 2020 11:39:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com
Subject: Re: [PATCH v2] dmaengine: ti: edma: Support for interleaved mem to
 mem transfer
Message-ID: <20200225060937.GJ2618@vkoul-mobl>
References: <20200210094455.3615-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210094455.3615-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-02-20, 11:44, Peter Ujfalusi wrote:
> Add basic interleaved support via EDMA.

Applied, thanks

-- 
~Vinod
