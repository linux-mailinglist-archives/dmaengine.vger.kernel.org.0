Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120083793BD
	for <lists+dmaengine@lfdr.de>; Mon, 10 May 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhEJQ2f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 May 2021 12:28:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhEJQ2c (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 May 2021 12:28:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 790B06115C;
        Mon, 10 May 2021 16:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620664047;
        bh=o1jyZ+kw6gwlssERlfWpnAj5Bx1Dsf0kt1gLfw9KgJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FtAltezPdS9dCHXachU669IU5Jfw/MANG1LdRyLyassBX8TueW1qBH3goRBHRAUoZ
         Y3WZs2S/E17t/XeRIETdIMWnTIkFKYbIF3yBFqt9PRVHrt2rGUwCyaZcwARWmy/Jgi
         LYYddY+b7j1Ap5gRJ0DzDgXpEZ5lmjG2FU37LPinfPoleZKxV/ui3XzWCIk6FkQh0D
         ljRI/GkH4NpGGkexmtMFcLuOcbPJZPMZnUTzj7qCywoxi4SWx3eO6t3kFHAbx9NOII
         9DXiLwNc2r3JI/LJ2EdPecprMFNp0vemWxAzDiUzVRMIxjpqTfxh5txR8PAP810I9u
         aQsNPWbnE4tPw==
Date:   Mon, 10 May 2021 21:57:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: dma: convert arm-pl08x to yaml
Message-ID: <YJle6wTwe6ijAmQA@vkoul-mobl.Dlink>
References: <20210430183651.919317-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210430183651.919317-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-04-21, 18:36, Corentin Labbe wrote:
> Converts dma/arm-pl08x.txt to yaml.
> In the process, I add an example for the faraday variant.

Applied, thanks

-- 
~Vinod
