Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF833D0C6B
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfJIKR3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 06:17:29 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45621 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbfJIKR2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 06:17:28 -0400
Received: by mail-wr1-f66.google.com with SMTP id r5so2108699wrm.12;
        Wed, 09 Oct 2019 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rjaYpkcdgVq1Ytww3HoMud9TI2f6caXQj6YPGdN+e0k=;
        b=aelG5uB3AoOyuYYLVuEOd6mTjlOgUG3CjynlOPLQq2P72KPv8JIXV+BBqk0FZtKrKK
         FJy9iIwkfpxYYI32HGbmOY8RqnHVS4ZbM/fWfl9gRQmuAACBkeZoQOA/UKwYqigOUzCC
         vAxZw0dhn6LMFiismlHuDTJEYMo4cD1gCAQdunMdLsx+jiIfL1vevEqbe1KkL8xhU+AF
         euv6cfD+QeAKZnCrHYU6c1cQMp19hFwJ0kHJV53qtRh7fxQNHZxIcJada7WoMVInCUHH
         nziY97TNDM9GL625orHdpEP1XbUZPMV2hc98H1DFkIeYRiFMnrybkIkMr3vlzK25kKa8
         tZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rjaYpkcdgVq1Ytww3HoMud9TI2f6caXQj6YPGdN+e0k=;
        b=eMpDYAdlLD3Uj0pAuobvIx0PlYLN++P4ubXc8AIZkoBfab23T7YnGcFyDlAdh/NYlJ
         K/Q0VuTY4izhoEiSzy++RGjvUIvZRIAWECAjMm48pelQPLWHQRkoIeSFEE70lomQhrjq
         wkYOb+qEUkC278t8N11fbge3IrgrBD6Oq9RZT3YEK4sK3hVpuVKlfz0l2MSgRAbD6iB9
         /o6I4iWCWziXu08y10GvV+JsVzqcknNo7KlDF3aKT6gzkZD0NVlkskHxT/93wm4gd5ro
         HyDCI0jeL9zzLBlpr+Wm8xXUeraX8SLPEcwTw7FA4qJggfqLQwctxAddYg9CufI13xoJ
         63Uw==
X-Gm-Message-State: APjAAAXmAglN8nTbikKPqmV0kS0zNg5y2twerAFqTrNlIYvBwGQCAeyD
        b08s+yuepNP82RJI3pDvZBsy4G3H
X-Google-Smtp-Source: APXvYqzQReCxE67VrpcC+uJwGYwSVOvO7oEJ3cvsFoI8C7MbuuFXycy49ZeIN5ZdITK9ljRbXcNnmA==
X-Received: by 2002:adf:e3cc:: with SMTP id k12mr2266353wrm.176.1570616246460;
        Wed, 09 Oct 2019 03:17:26 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.14])
        by smtp.gmail.com with ESMTPSA id g3sm2561692wro.14.2019.10.09.03.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 03:17:25 -0700 (PDT)
Date:   Wed, 9 Oct 2019 12:17:24 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] staging: Support Avalon-MM DMA Interface for PCIe
Message-ID: <20191009101720.GA15462@AlexGordeev-DPT-VI0092>
References: <cover.1568817357.git.a.gordeev.box@gmail.com>
 <20190919113708.GA3153236@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919113708.GA3153236@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Sep 19, 2019 at 01:37:08PM +0200, Greg KH wrote:
> Why is this being submitted for drivers/staging/ and not the "real" part
> of the kernel tree?

Hi Greg!

I sent v2 of the patchset, but it does not need to be part of the
staging tree. I CC-ed devel@driverdev.osuosl.org for reference.

Thanks!

> All staging code must have a TODO file listing what needs to be done in
> order to get it out of staging, and be self-contained (i.e. no files
> include/linux/)
> 
> Please fix that up when resending this series.
> 
> thanks,
> 
> greg k-h
