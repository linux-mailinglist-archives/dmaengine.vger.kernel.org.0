Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E136A851
	for <lists+dmaengine@lfdr.de>; Sun, 25 Apr 2021 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhDYQRG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 25 Apr 2021 12:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230288AbhDYQRG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 25 Apr 2021 12:17:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EDB761363;
        Sun, 25 Apr 2021 16:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619367386;
        bh=mnUKMeurzof7SYDsHIcy+IPWCYjV/kIYWE3itQrOVew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyoNVqkR4np7QMhEjyxr/O5jeG/nI3HKJ3LAGozM4xv2lJQ0zvzaUJYJB9y8kvckm
         L2jcLp5gE/7DFHWexxt+esfq3j4Y+80ZrKLDGpY1hItWekFfHt6DGpBpGYtqthN/dt
         BXXejMbh+hyEnaKURtqUlC0qnvOR4EeJxSQpaygKZ8+qFbGmG45pPD0hf3B4hFXAeI
         NtqAbBPQhzejhCk7C7FBTU3lJD+VKBaGtTANR0FtoRalEXF/u8foPgrTuDDZAVM38u
         geaDf+rCu7W06U5F4pK6q1mOjtBzyXX7RlbQIQw0hqgHH4RbIXzvzqXERQ/CzNU2cA
         dk5uHyOAlUXCw==
Date:   Sun, 25 Apr 2021 21:46:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, dave.jiang@intel.com,
        tony.luck@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 0/2] dmaengine: idxd: IDXD pmu support
Message-ID: <YIWV1ufq4WgS1WNH@vkoul-mobl.Dlink>
References: <cover.1619276133.git.zanussi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1619276133.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-04-21, 10:04, Tom Zanussi wrote:
> Hi,
> 
> This is v4 of the IDXD pmu support patchset, which is the same as v3
> but rebased to the latest dmaengine/next, no other changes.

Applied, thanks

-- 
~Vinod
