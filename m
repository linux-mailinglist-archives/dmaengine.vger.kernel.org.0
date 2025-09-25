Return-Path: <dmaengine+bounces-6718-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CBEBA1B81
	for <lists+dmaengine@lfdr.de>; Fri, 26 Sep 2025 00:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96CB24A1BF2
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 22:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129142E9EAE;
	Thu, 25 Sep 2025 22:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aDtkPY0L"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C78022D4F9
	for <dmaengine@vger.kernel.org>; Thu, 25 Sep 2025 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758837663; cv=none; b=kmQvMbVsN1E+/GBeFgk4bIa+zlhymJdO6lhMdJ4SDHi6DlBWXNZl2Uv2jQYgfQsW8IOSeym3UvBk0rq34w8aDBv3jA2M+boqP5AVC6Bnjrfv5qdXd4PGY38Jtg/OYlAs4c7ecdpAQP+hD8zxfbWYwfZBNQ79KBvLnK8nq5Zgumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758837663; c=relaxed/simple;
	bh=/D0ivGpqDXUL0Q5UF8JovOsUXuF2O38FODp86EMyvJI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=g4zErBoyqsI9yX4wFugpckQwqHA6RBpsiEw+CsaWB49aGMzYJqkRJRzIason8sUB9PshJedz+u5P0iPl89l2VWcjI58R+ClgvvmUDDSDAW7czFkccHNH4G46ieVsVdxc5A898vzbCkbJacdcRJK3Lvz0uZcIK/DEzcAQXcuDSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aDtkPY0L; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4A5B455A;
	Thu, 25 Sep 2025 23:59:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1758837573;
	bh=/D0ivGpqDXUL0Q5UF8JovOsUXuF2O38FODp86EMyvJI=;
	h=Date:From:Subject:To:Cc:From;
	b=aDtkPY0LV+8ZEJ017sr33tGqSEE89S+cuc3YL13wtPuptbpuAx1BiOf2DgfOGNiN+
	 gqq3o6fqndVbbp6ET8H5erqV5ECgCc8+e0I3rB7seQe4+eGU8eW+UQ2d9z3Fwrzn1Z
	 KWjJOhQ8W4Px4rBdn7OkEDtubRQMSN70cOXNLl8I=
Message-ID: <385748e2-11cd-4230-a748-36352887fa6d@ideasonboard.com>
Date: Thu, 25 Sep 2025 23:00:54 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
Subject: Guidance on API for writes to device memory
To: dmaengine@vger.kernel.org
Cc: vkoul@kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I'm looking for some guidance on the right DMA API to use. My use-case is transfer of a fairly large 
(74kb) buffer from system memory to device memory, to program an image signal processor as quickly 
as possible to guarantee that it can be done in the blanking period between processing frames from a 
camera. At the moment I've implemented this using the dmaengine_prep_dma_memcpy() API with the 
transfers triggered manually by the ISP driver via dmaengine_submit() and dma_async_issue_pending(). 
This works fine on the platform we originally developed the ISP driver on.

Now that we come to try it on a different board with a different DMA controller driver, things 
aren't working - I get partial writes of each 32-bit register with the top 8-bits filled in and the 
rest all zero. That transpires to be because the DMAC driver (drivers/dma/sh/rz-dmac.c) hard-codes 
an 8-bit bus width when you use the dmaengine_prep_dma_memcpy() API. Perhaps an inability to 
configure bus-width is expected though if the dmaengine_prep_dma_memcpy() is really intended for 
system memory to system memory operations, which leads me to think I'm using the wrong API.

We can configure the bus width with dmaengine_slave_config() and use dmaengine_prep_slave_single() 
however the driver then mandates that the device address not auto-increment, and our understanding 
is that the intended use-case for the API is really write/read to/from a FIFO register rather than 
to a block of device memory, so that also seems inappropriate. dmaengine_prep_interleaved_dma() 
might work but also doesn't really seem appropriate, as our data isn't interleaved.

I'm a bit unsure about what the right approach is to memcpy from system memory to device memory, 
where the destination side requires a particular width...does anyone have any guidance please?

Thanks very much
Dan

