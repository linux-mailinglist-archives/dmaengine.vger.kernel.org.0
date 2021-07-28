Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F32D3D8DC2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jul 2021 14:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhG1M1b (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jul 2021 08:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234701AbhG1M1b (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 28 Jul 2021 08:27:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EC1B60C3E;
        Wed, 28 Jul 2021 12:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627475250;
        bh=fD9tcv5b7J+vdxcFgOwFl8xpZTW72kApnKjQIwKIfRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bhy6ifpZBmF/5mv3hiuzHXiwhQ6TALUPiHGrSARrJt/KAk1wpoNw+HrkqsQ1jRbid
         U8FxloUAohG6TjlRuhYlVVLHgbHKfZLc5PcrgjSxhcEu2oTARzeUPw0vP1uc6UWt58
         PUqoB0eoH2knpaFWZvb5rvMHpibRL+GVKkB2syJ/e1dP7n8osT/wC57PlJg8ozWsj9
         HLTaRBBceeULbQK5EjVPl5gibbOVqdyOTLHWS5tNQ7881CSrs/3WcN1mGkEm1Wnkba
         YM+RUaay8MhhxuuMNtqNtHeDLVT9QrzLtDUuBJfK+yjK9I/xZUiG31muXqgUHy8hSC
         2kKOZAdH6XzGA==
Date:   Wed, 28 Jul 2021 17:57:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: Set defaults for GRPCFG traffic class
Message-ID: <YQFNLiREZXa6Z6P4@matsya>
References: <162681373005.1968485.3761065664382799202.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162681373005.1968485.3761065664382799202.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-07-21, 13:42, Dave Jiang wrote:
> Set GRPCFG traffic class to value of 1 for best performance on current
> generation of accelerators. Also add override option to allow experimentation.
> Sysfs knobs are disabled for DSA/IAX gen1 devices.

Applied, thanks

-- 
~Vinod
