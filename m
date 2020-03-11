Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26FE518152B
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2020 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCKJk7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Mar 2020 05:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgCKJk7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Mar 2020 05:40:59 -0400
Received: from localhost (unknown [106.201.105.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFF382146E;
        Wed, 11 Mar 2020 09:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583919658;
        bh=r7jiRcbHhhGjHyK0P//H95LuR9L+cQjVWw1QEjnrd6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIh2TlAShHY2UsPAT3QhIaWmcOs+K8dT6pKOITf9CzsVs3+m7az38whDV3INCHKJA
         n4yFkiRFqE6gq0wwXhLlGTzIv1lRwsuiFA7KxDMUk8wO6VUrW8YV6nNphTXhUluq3+
         dX+1AmgBrRIkuiR+MZpY0/yAzTaPQpVgV5izDkkA=
Date:   Wed, 11 Mar 2020 15:10:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ppc4xx: Use scnprintf() for avoiding
 potential buffer overflow
Message-ID: <20200311094054.GS4885@vkoul-mobl>
References: <20200311071606.4485-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311071606.4485-1-tiwai@suse.de>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 11-03-20, 08:16, Takashi Iwai wrote:
> Since snprintf() returns the would-be-output size instead of the
> actual output size, the succeeding calls may go beyond the given
> buffer limit.  Fix it by replacing with scnprintf().

Applied, thanks

-- 
~Vinod
