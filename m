Return-Path: <dmaengine+bounces-9512-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMabE3mcummHZgIAu9opvQ
	(envelope-from <dmaengine+bounces-9512-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 13:37:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7066C2BB919
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9446D30229B1
	for <lists+dmaengine@lfdr.de>; Wed, 18 Mar 2026 12:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F463B2FD1;
	Wed, 18 Mar 2026 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY3ql0aY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4444F39B975
	for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773837347; cv=none; b=OsJnLTi9uQX2+RwkOSPZfsZR6E0vVDGR5eLcihYobNqz/RDipoj8GjJRRvvyHiPXkbGEV6bdyUQpbxJcYpC+G6sNkV34TEiA8hptPQs3OiqWDsIL8mTo0LuoBDagdlOXA2jSkbJ3e+/nAgvqSdWCkDr7QXGp6u0CxDjWbzUDOp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773837347; c=relaxed/simple;
	bh=cOgD2Au3jU0NZ1uop32tvxf2TJtsFWWAmf6y16JZrEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE/HUVkSnae2dFpjl/RXa97jevvGMoOIZKi2IA8d7qYQwh9p2ZRqID07DcGNDevtqPoZRLQyOBR8jJMeXE7AuKJZ4XHqtntWz1A1ABMr38TQyW6drDO4wxYd1rg6T7sAFSKRTflFwwvL3XGmr9przazTvdmRFhJSKBueZYheBZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY3ql0aY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82987437624so571796b3a.1
        for <dmaengine@vger.kernel.org>; Wed, 18 Mar 2026 05:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773837345; x=1774442145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XHpYNQ3KDR2HDAUWZ7ar2fFYtc/VU+5Al63pdYj+mU=;
        b=fY3ql0aYWJR2x0j2eHyA7vY8PD0okaJQcDuN8ijRk1ojTpPsW6VcjLO1QTl+WqMIRP
         gMUglA0tqAIXFuS/6QCwTxigFNsvX/J9YrL8pD8gRONXP8u6rp0CeV2E46QAfgPCU/Oy
         6HNa2DFOBP7vdDrcegyzHZ0VwIUI4Izl7q+8pHEPmGd87TDI5OfOCRgWBTlOvS0BshWp
         BR1Z/KfeAAc4hUbNN+RTIrrNc511yiJIhVJMJqGNX1zamX/hEZDz3yV040xo5R4JLvYW
         moFSkDxMXgNRn0xBpizxTI93JYZXa2Lkvpjz6iRWlVs4/xNdRb/+3FrG6CquYkmT7Fyl
         7Q2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773837345; x=1774442145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XHpYNQ3KDR2HDAUWZ7ar2fFYtc/VU+5Al63pdYj+mU=;
        b=HyhplVY2FTmKuF9j92GdBtHkSRPaIMVHdvEy2xdSW9T49xnL9avJ+eVtoCLLUUeMdd
         E0X6/zxNoYzrdiJpAWEV1Db0xFzY3NOYOc49nLY74Rx4//M3NdhU+1kCNhMX5LJa8us3
         Sm+huxEIAh/PvK6vBFsfBPVXsBQSYfNEHWHmX068pkAEUuC7oWXLYflkqqd1dl9PpvgD
         mmBF6b9j0r79j7xaLxhwjfsEg7cgxq3pAOyXfE294+NQdSi1W2IGB+aOhrBD9Lz/qrms
         G/TT2Bya0AgPvBeztx9mOrmsMctAKk+fD3VeXmZOKl+YrStQZZ3/P72rKZFwwFPJ9lMW
         ia9g==
X-Forwarded-Encrypted: i=1; AJvYcCWdaAajNvNKUL7cebfA/t4jm3/HP3bFAEt1H1bqaDLZpkIl0QMCj8VUy9Kw00+K5LWVRkr3tF5riao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw85hbweEWi1RY7I/bo48ernMGwumcmkEWp7WDPRT2VPUb/LT0z
	VTKUmjSu7mMzHk2hVGs6Abn23YfZO8CZYL7hNCeWfyikgom3pEuZUoUd
X-Gm-Gg: ATEYQzxwsMuu6K0TTOpv8Q7psdRGGR39JPcLJ1E1gKfbjkZWpUTA0JgSaOLbNDwtaui
	R+IXKtHcX4ENc7PiSmgWK11IZUJrJuyu4+2UsAnaGtoDSK0BtpiAZUuNHX59YID+PGoAYT5ID6I
	qLdR2JGF5/YP+RR6AjhlkSaSSlyZOUmo0JSj8WjnyE0bv97B0y0ME6GqQn3BXROe9LEMzZHolw2
	jt1+reM4kaQyL1l6ro+pAnSIv5RNuLkz0Xo03+UxpTA1HSPG1fngC0l8jBz5+iG7k9mpuuwKmQt
	nFZycPATfzBUNroo0H8tn5YDNH/y5zIXwHhp1bhNhYcdUIwMf6OIjPb7QDd1SxxDkUfEVu00xx6
	je6Gz6R0ok8rcvV4w2m859ij4E5Z569WCWpR+bqmQJMTcpbMXTkIp5Easz4gbMROrLJK+3KrdlX
	2fajoeol9tZjYtbY8Kx0UOEbs=
X-Received: by 2002:a05:6a00:4006:b0:81c:717b:9d31 with SMTP id d2e1a72fcca58-82a6a02b014mr3004715b3a.2.1773837345543;
        Wed, 18 Mar 2026 05:35:45 -0700 (PDT)
Received: from bsp.. ([2409:40c2:100e:3b8e:f351:1dc8:4b9e:9794])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b541cafsm2756120b3a.12.2026.03.18.05.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 05:35:44 -0700 (PDT)
From: Rahul Navale <rahulnavale04@gmail.com>
To: Folker Schwesinger <dev@folker-schwesinger.de>
Cc: Rahul Navale <rahul.navale@ifm.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org,
	michal.simek@amd.com,
	suraj.gupta2@amd.com,
	thomas.gessler@brueckmann-gmbh.de,
	radhey.shyam.pandey@amd.com,
	tomi.valkeinen@ideasonboard.com,
	rahulnavale04@gmail.com,
	marex@nabladev.com,
	marex@denx.de
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction reporting via device_caps
Date: Wed, 18 Mar 2026 18:05:21 +0530
Message-ID: <20260318123524.4959-1-rahulnavale04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[ifm.com,vger.kernel.org,lists.infradead.org,kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,gmail.com,nabladev.com,denx.de];
	TAGGED_FROM(0.00)[bounces-9512-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rahulnavale04@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ifm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7066C2BB919
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rahul Navale <rahul.navale@ifm.com>

Hi Marek,

>If yes,make sure you only test these three 
I have confirmed no other pathes applied on xilinx dma driver.
I have applied only three patches provided by you.
and tested audio but facing same issue. 

