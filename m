Return-Path: <dmaengine+bounces-4789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CDCA73E33
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FEC189A961
	for <lists+dmaengine@lfdr.de>; Thu, 27 Mar 2025 18:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769EA21ADBA;
	Thu, 27 Mar 2025 18:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B+cCn526"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1117717A2E5
	for <dmaengine@vger.kernel.org>; Thu, 27 Mar 2025 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101792; cv=none; b=qm4a7qBm3YK4JZaA+KBfPbuPGxkbOnSAXZA6cJhsKJIuyMV8pYtZdnURQCqTk7oITot6NStRtSuqWm/ebScLPcDXvjwgtv7VTuuevYks4imjaywCwx4fdZr3Tf4Wh+xXqiykr7ufOy+5oQedYcnxRUN/IPFgR1UiRDYyRKXiICw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101792; c=relaxed/simple;
	bh=NApNX0GLTCtTtLGZCrP3NkAClNc+Nn3/NIIxphDYeTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4Iq0Df6I9dYeO01iAGECrDUZhECj74cxdhw01X4IkK75IAN3B/ZPwxxibS4hGI7wFltTRlDgXq2HpkvFepxztEH8vBRYCm3tjT0UR3iJ37W0sLv2tFnbg/8MP8UHAYiPEb8gLxZPOhcTUt2hQH/80QKZk87jNW/fA9R9C/UssU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B+cCn526; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2240b4de12bso39770525ad.2
        for <dmaengine@vger.kernel.org>; Thu, 27 Mar 2025 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743101790; x=1743706590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NApNX0GLTCtTtLGZCrP3NkAClNc+Nn3/NIIxphDYeTs=;
        b=B+cCn526Td0+3SZRtKVdzt3jj3vpZ73C5OZ1jb8/q34nAaHGIsr8A2jMqq+dAvlDXD
         7IOTIGj74x6CKD1NWjIe1pnJwcE/iwbM0HGgwysK/+5gn90zE9ocMOpkhUxSoiT134BE
         MYVsEKOHY8BpY9kWzY/y5zICbHVoVy/EboUZPRXVHXgBQUPEtjE1zFRIVA0r/ozAgN7R
         DclmRA2ueWdTyYUC4bAfX7xsZTbSECVuOkudHzgNfbM7CQ279g4GjqAelHO4bStbx6CP
         kjz5KaijLbVUoYb6NXPVneZkb7ECOqimjSIx9rez+2pJdFvPDCH+vZVSBGWrjnxstNri
         wZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743101790; x=1743706590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NApNX0GLTCtTtLGZCrP3NkAClNc+Nn3/NIIxphDYeTs=;
        b=KAwAJrkP7CHr9psJMiBcHCqniW1xr3xYFrv9vfi0FfgBhaWltk5SerPZ84E6DSA1qB
         0wrWFy/JHwd+FyCpn0zGZwexu3EmBV6y80XC2FJgTSo76uaDqiqtwPIqDm0UvXKfnmsx
         ykZs1JqKlsTTxnZiIGnQinsSht24Y/YGChuKm9geYK6wU+rYWYzAY7GKTwm5Sfw4qcmI
         IWhbQWHibZ8xMWFL9KfNO7XcMLAtdccq7rGNP6f8V9v0Q5ksFkm3F4iWcty3WyReO+Ed
         YZ9nDDAQBr51cvsaSby8jTCNH2YypWmpu/48tLSMHg9nKiyEdS/NtGqJBmaTJ8LfO/Kz
         yZ+w==
X-Forwarded-Encrypted: i=1; AJvYcCXMJFdqFWqKof1jB8lNfcpuP7MhDCkrCvE0ERjImyjA2RW/FVO7RhE8rxlvyxjdE+gVKcphEfCA1cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRXi3Dmz3KIBX5VUjHlVcz3VWa0wNO7Ey7tWj+26tpALCrkCeG
	t6VSVBEKRS+7IVYnZ6b+NTV9UZ/DkSLBcOy82JlbVOH9/e8BsBd9AS379DSlKIO7gbK752VJaYl
	Y
X-Gm-Gg: ASbGncvxnN/3Z1VdUmQNhSBrIrNWyOlJHCdKixkYfRLZjezzT5qbYI8LH9H+dX7o7RE
	KNbx4NPEAV2QC+rIaXRPDapkSXz/ry0ZLf5ycZTHgnzCf8pw2P8YA7hfUxZrDgU3hYhpjHalZ5m
	DPkHAywY4FpJVX0NAIPG/ivZUpGQLpi4KVxrjqpNwM54Q0wEgOyLTZ5knhxF9Hnxqxl/09c+93E
	yaB1/0XTNcroGe+ku2ZhdhwAvNcYNO5a9aBXzWq3aOjqJZTZZzV19ju5+3jqvgMtr1PyZ5q3DRW
	TUnM+jyQKJNBY6z+VXL5IbhINjAdIVl/V1k928dx8XGyY4lNfL0v/7ryELZLoJAH7S/ZICnzZ/w
	K
X-Google-Smtp-Source: AGHT+IGCpIDMCTNO0zjrjz0mOOh7QmyVHnmtYl4M+loQ6kezARsOXQry7QMc8iGjESsssOBa6P/Hkg==
X-Received: by 2002:a17:903:1cb:b0:223:f928:4553 with SMTP id d9443c01a7336-228049582b6mr78496805ad.44.1743101789928;
        Thu, 27 Mar 2025 11:56:29 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e52:7:61f5:481b:ce69:3d3b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710a1ce4sm170113b3a.131.2025.03.27.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 11:56:29 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:56:24 -0700
From: Kevin Krakauer <krakauer@google.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	dmaengine@vger.kernel.org
Subject: Re: idxd: shared workqueues and dmaengine
Message-ID: <Z-WfWC63NbzoU_kk@google.com>
References: <Z-SWM-F0O9XU1zqp@google.com>
 <3a28b0a6-3c7c-43b9-a592-111692d3c1bf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a28b0a6-3c7c-43b9-a592-111692d3c1bf@intel.com>

On Wed, Mar 26, 2025 at 05:15:37PM -0700, Dave Jiang wrote:
> So I think maybe a new sysfs attribute can be added to wq to allow the user to choose whether to make the channel DMA_PRIVATE or not. By default it can be set to DMA_PRIVATE to keep legacy behavior. I think that should solve the issue you are encountering?

Yep, that would do it. Thanks for helping me understand -- I was
wondering whether I was missing something.

Easy for me to workaround for now, or maybe I'll just add the sysfs
attribute and send it to the list. Thanks!

