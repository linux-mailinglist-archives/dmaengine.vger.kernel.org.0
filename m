Return-Path: <dmaengine+bounces-6542-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26722B59B7F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 17:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 637137B618F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Sep 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373934574B;
	Tue, 16 Sep 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A5n3fHiM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9DA2D12ED;
	Tue, 16 Sep 2025 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035308; cv=none; b=Bq/6UojnyEKGlgsEp8YXaFkaoiNicR30xq5X3UFGRrWUzrAFclLxki1JPuuekzAYWoK4RW9Sv7qGlKAIoGthUCGcgO30bLkPEQ00UADnOWYiPSX9vN3LUyDqebggsK6g7cID5MonFfBJD6wH04JzUpHknWJDuc3VNrISZH0S+hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035308; c=relaxed/simple;
	bh=eh6QVqz3lffVGTOiB5L34b3cIqw2nKOaD4q8ix1TkTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAcWQiNMV9G7nXbW7Tui19f8fpw3IkdOtsx2SQOGe+z5Ry1MEY5+o7e9f5dse64/aIxcXEWMSW/U8sOMLx4JaK0CNh5wkZHJA4yOneH7nAJ/aRwk+XFINJAK3NZEzUuU93TeDWWm6T/yhOj8U/1WTFRSa6I3lK0RhtFm+RBPR+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A5n3fHiM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 205DCC8F467;
	Tue, 16 Sep 2025 15:08:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7595F6061E;
	Tue, 16 Sep 2025 15:08:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B71A9102F1788;
	Tue, 16 Sep 2025 17:08:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758035303; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UQOE3eUMvpfqrZERSP7sEINW/46CzMSN740+oyUBq0U=;
	b=A5n3fHiMc942pBxiiBYLe3Ui+XTe2GdJGXpoLjonwep6Fm3HRDcBDJ2kfucMjiUtzqSqDu
	Pyuq0wuB08xAtdbWdJItZ3DbMhPoES66m5eMbmI1oNPHQTo3J8VCwI781aAq1NgKydtDPW
	qILfxtHsmsefAfhKMely3Z5OOSLIfXq3kaHKRUcQkiVw0/4kKeNlrAMcIhBR0YjGknvHU9
	IsUDRMKQ+Fa5VGZdjDZXEt4Pkdl5jZy+W1rrS1e27cb5NEjdAXud/EVL9S23Uggm1hveZ0
	raBWRhUnhJB2FHm9Qab44gXXyrsp/SY5sdEv4eB0XY9MYU6DoM00TASOMfVKwg==
Date: Tue, 16 Sep 2025 17:08:07 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>,
	dmaengine@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-spi@vger.kernel.org, nuno.sa@analog.com,
	Michael Turquette <mturquette@baylibre.com>,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Trevor Gamblin <tgamblin@baylibre.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mike Turquette <mturquette@linaro.org>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v6 3/7] include: linux: move adi-axi-common.h out of fpga
Message-ID: <20250916150807090a7e5f@mail.local>
References: <20250519-dev-axi-clkgen-limits-v6-0-bc4b3b61d1d4@analog.com>
 <20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com>
 <175133153648.4372.1727886846407026331@lazor>
 <202509161304166bf210e2@mail.local>
 <711b5e34-3534-440c-8914-ddb41987ee8d@baylibre.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <711b5e34-3534-440c-8914-ddb41987ee8d@baylibre.com>
X-Last-TLS-Session-Version: TLSv1.3

On 16/09/2025 09:55:13-0500, David Lechner wrote:
> On 9/16/25 8:04 AM, Alexandre Belloni wrote:
> > Hi Stephen,
> > 
> > On 30/06/2025 17:58:56-0700, Stephen Boyd wrote:
> >> Quoting Nuno Sá via B4 Relay (2025-05-19 08:41:08)
> >>> From: Nuno Sá <nuno.sa@analog.com>
> >>>
> >>> The adi-axi-common.h header has some common defines used in various ADI
> >>> IPs. However they are not specific for any fpga manager so it's
> >>> questionable for the header to live under include/linux/fpga. Hence
> >>> let's just move one directory up and update all users.
> >>>
> >>> Suggested-by: Xu Yilun <yilun.xu@linux.intel.com>
> >>> Acked-by: Xu Yilun <yilun.xu@intel.com>
> >>> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> # for IIO
> >>> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> >>> ---
> >>
> >> Applied to clk-next
> > 
> > Do you mind providing an immutable branch for this as my i3c tree is
> > introducing a new driver using this header and so it is going to depend
> > on your branch.
> > 
> > Thanks!
> > 
> 
> This was merged into mainline in v6.17-rc1, so I don't think we should
> need an immutable branch at this point.
> 
> If you are modifying the include/linux/adi-axi-common.h file in the I3C
> tree, FYI there are some changes in the SPI tree that just got applied [1].
> But if you just need the header in the new location, it should already
> be there since v6.17-rc1.
> 

Hum, right, this makes me realize I din't rebase i3c/next on top of
v6.17-rc1

> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=67a529b7d3c50a56c162476509361f4fe11350dd
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

