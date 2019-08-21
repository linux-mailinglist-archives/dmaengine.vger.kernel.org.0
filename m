Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66799970D2
	for <lists+dmaengine@lfdr.de>; Wed, 21 Aug 2019 06:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfHUEM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 21 Aug 2019 00:12:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:45218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfHUEMz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 21 Aug 2019 00:12:55 -0400
Received: from localhost (unknown [106.201.100.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A025206DF;
        Wed, 21 Aug 2019 04:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566360775;
        bh=qcEQgVoNCUFOmWm4YOfN+msxE1DbtuqC2ZTcnt+RPnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzXaiXFrZIH7V0LmhqSxqWlGM+OB7m4PbO4MMjZ2WRPufIBCDE5LrjgpJwhRL4KAw
         3tNg1XRWcyMYMTcigl6Vg7dWailBHOB0tQCA7W6JE5v/NXSpZ3hYYYqfKB+s9gEztG
         MrHkmOtAJZgOOldYnONQWflWlBY6Mzn8xRSJptEc=
Date:   Wed, 21 Aug 2019 09:41:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 00/10] dmaengine: dw: Enable for Intel Elkhart Lake
Message-ID: <20190821041144.GG12733@vkoul-mobl.Dlink>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-08-19, 16:15, Andy Shevchenko wrote:
> On Intel Elkhart Lake the DMA controllers can be provided by Intel® PSE
> (Programmable Services Engine) and exposed either as PCI or ACPI devices.
> 
> To support both schemes here is a patch series.
> 
> First two patches fixes minor issues in DMA ACPI layer, patches 3-5 enables
> Intel Elkhart Lake DMA controllers that exposed as ACPI devices, patch 6 is
> clean up, patch 7 is fix for possible race on ->remove() stage, patch 8 is
> follow up clean up and patches 9-10 is a split for better maintenance.

Applied all, thanks

-- 
~Vinod
