Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C7F34640
	for <lists+dmaengine@lfdr.de>; Tue,  4 Jun 2019 14:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfFDMJr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Jun 2019 08:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726847AbfFDMJr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Jun 2019 08:09:47 -0400
Received: from localhost (unknown [117.99.94.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D571323CA2;
        Tue,  4 Jun 2019 12:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559650186;
        bh=aW5xWIlY9u6kIytF67/XU943TuWwFqg6v4drQua6ZoU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jpyjucptM/P1GGfu71jWsXkFxxOOfF9T4LIZ9A6SvEAk9HexpCTTz55slvxV2PxKB
         U37CCYsWVIgpS9O84SBVwx2EaFatDOGFnlyJwcqKcNsM2kYnhlbWIPhFSto6ELi6ZR
         rx3NMS9+MUHQDPzmPxSacdTpDpX0wSAqpblx4O2I=
Date:   Tue, 4 Jun 2019 17:36:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V3 1/2] dmaengine: fsl-qdma: fixed the source/destination
 descriptor format
Message-ID: <20190604120638.GU15118@vkoul-mobl>
References: <20190522032103.13713-1-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522032103.13713-1-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-19, 03:21, Peng Ma wrote:
> CMD of Source/Destination descriptor format should be lower of
> struct fsl_qdma_engine number data address.

Applied, thanks

-- 
~Vinod
