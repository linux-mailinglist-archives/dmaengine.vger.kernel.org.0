Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1D41ADC98
	for <lists+dmaengine@lfdr.de>; Fri, 17 Apr 2020 13:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgDQL4H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Apr 2020 07:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730267AbgDQL4G (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 17 Apr 2020 07:56:06 -0400
Received: from localhost (unknown [223.235.195.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB722078E;
        Fri, 17 Apr 2020 11:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587124566;
        bh=YuE3Ip9k8tEgEerJuZa5XVgrgjhme/xQBUVEpvc0pEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnpOPVBdQcqTXLGxlZCLH3MbjROORZwPIvhJGNOVYJO1Bq1fdweZ4Tzj262yzPTHr
         I7zopQnTuiYTCa08aZQp0jGiX3jNauRKVzXXPyUGGswbXRaXICoWVVYU28Uj9O09X9
         MaG2vLlDwtoYhIDwtbmtvOJveCIM6jN5WnC7U+Vw=
Date:   Fri, 17 Apr 2020 17:26:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Stefan Popa <stefan.popa@analog.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jiri Kosina <trivial@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial 2/6] dma: Fix misspelling of "Analog Devices"
Message-ID: <20200417115602.GO72691@vkoul-mobl>
References: <20200416103058.15269-1-geert+renesas@glider.be>
 <20200416103058.15269-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416103058.15269-3-geert+renesas@glider.be>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-04-20, 12:30, Geert Uytterhoeven wrote:
> According to https://www.analog.com/, the company name is spelled
> "Analog Devices".

Applied after updating the subsystem name, thanks

-- 
~Vinod
