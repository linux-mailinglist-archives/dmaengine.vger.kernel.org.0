Return-Path: <dmaengine+bounces-10205-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEZ8J+P29WlvQwIAu9opvQ
	(envelope-from <dmaengine+bounces-10205-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 15:06:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0782D4B215A
	for <lists+dmaengine@lfdr.de>; Sat, 02 May 2026 15:06:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCF363008D23
	for <lists+dmaengine@lfdr.de>; Sat,  2 May 2026 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29BBE3803D4;
	Sat,  2 May 2026 13:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG9a0a5D"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CC136A022
	for <dmaengine@vger.kernel.org>; Sat,  2 May 2026 13:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777727201; cv=pass; b=mpWVD80eJODgXipGIocgA1FprxZ5Mf+70Ujq9t5eFgjWCinJQ43Ge6UDLQvQW3LIdPRzm2R/otu50TkRjvweKPwXdmhO1JX37j6VWiFdIOCKmc19CXB3qRi/OPACYtB82a0Ixnqdb2ENsphUqyifFR1ACW6itAB06c8/yzzFMDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777727201; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OYQnxIon115yI5Zm6K8qbW8hB+ewdMB2iaVWwGZxk4719DRQlLXxIbRRAmE/MJOXe+vKO9MyOBWNDZOMYZdDMDYtUt9jLgMb2ZeAUpojsOAQZcyYVp7m4qY5/lEwHkrzaZ0s7AHcvZkvwNMbSQsn6sCofpkIuWaOUq1aH/E1G6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG9a0a5D; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so16191185e9.3
        for <dmaengine@vger.kernel.org>; Sat, 02 May 2026 06:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777727197; cv=none;
        d=google.com; s=arc-20240605;
        b=eSwOOqfqLVYc3P263a4GodP0XvyHUoheRpo/PG74fso8rKKj/IDLOWcMxWpZySDVQF
         jYHq1iQo47i8WvNVkd+iRtBEZXYBbpuXbbevBUcejFNbM2HtI/J7fMd0+clFLqRieiE2
         +ZJF2HDHIYJnMLqDb4d0kW0fOxccIAUuKJeTtfftqWaNrSWubceWImSasKYjxgiCz631
         0JeEAK1718XHHMlwMkAt3KbVVTZgcOS0SWCpMksr9dhAZawNuD+t0zVdME/zuT8xztou
         0pkIDSZCX5GPchVPB+Dbabi/jvmrhK9ZMB6+BuxsbzrK2v5McYznntkIxydDljXAGk8Q
         VZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        fh=x0gb+tlKrhcS4Naa8DWnY0hJFL7L488O+T3I0IAV7MY=;
        b=Qnmd4CkpH8XxyfCQAtf5GNQYNpy3kd8nXr8BE+QnNpWQeYS0rXg+ybgp60cLGivBPh
         UiiY3ZtKQWx+zIzNSFrlAmE4sIfF6fwWf3Y56+Wmw6drIn7hG+WWLQAMsNQuzNvDk7EL
         oGKPMKqULRbb7Ykh+VLL8DR356HMoHvhQ+U5IRKVojHC432bOPKVObyeSR0XuJpCQ2EQ
         FuuuzybWachafxNbFHmlUy8/8FbRrOqYBk9/dB7CU6XI8pOiKZtQ2RzAgJQQA3wut5Wm
         FogGPzCQYy0GCHExAlsBy1tGQ1R4BL6d6NUSUxt+Yy6Tc0m2em9h7jmQKpxE+ES6WgMf
         TcVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777727197; x=1778331997; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=PG9a0a5DGHaynSk0er1IrFa/Ov412y5fraANY0pdVPOZl20lcb2U3zMEicHRCdyzO8
         LrTOz9LKyfqxCG7RzYablJ6Xwu7SK43MzXxRWceh6qa8GY2WHDqInVDe4vTyeQ9hOsCX
         DU+oJ1tKtt8RMZ/jXZNVu/sHjrmVpG0YHLmqU/LLPF8q88FDVL1HGDjnJKanAt/WwQtX
         lcft2mWg3kIe/QPburBls6nHij3YoELpeSa5ZvROB2AWOVXrZ/kub2nluxJ8yUFgKhWy
         wu8ZByA5vSYYkmdPwDJ4IDxo/aKX+3KT+c0NZE+fMTZVj7IJ2A+LLeVKJc7SI8oMH1oA
         owWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777727197; x=1778331997;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=lCX6lSblsKNdECA9u18R8QMyPm4jFYvXF6mVYrl9hgkXQ4IQs8xthBqAOeIr8H2M8W
         ji8FVCSm24aQyGVz6Gurf1+wD8hC4rwKA5MtW/pynHQHOd7GLrxvLpRG65aHxAataQte
         TnjbS69cf9cnS7p0Tv2TBVbZGrK1u/40qZmgEALkBMEABbC1qwVqySMXd5E0jkFcre9z
         pRZl1oV+dPpku66r7Q+u5hGdAhPBxGj4v329VEbTL0ZSBkf0cNSRZy4q8xf9ZLZgIF1A
         0jX9giFKSZoyqGmm0p/vwkDLzyJwmMaU83/ROeBBcXGzTl0PUjrkekli22s/6QZJBAoY
         kzZQ==
X-Gm-Message-State: AOJu0YwnJsymEc9piTNUIyLYRhsSUznIyyQnlg+hDI1Bwrk6NzYDS4fp
	m991WWEbGWNx7GH1Fh5CoddMdOp3NTXnKsxXpQqDUr+3azxADWHk/9LOWwaQjh/myRaNfKZwDOI
	ByNTDyLKd/HiJuwoY8C0tIp4/J73YOPUgSA==
X-Gm-Gg: AeBDieuvnI2//LsGO4kChS4/TqunIV4YTIbn5MCsayr22nGUvklHDhgEbebyUzdAsSP
	rsoljeB+ApfIdLn7pIdclDgxgkAV80lfyvuFe/TYgoCnRs3RgLyqxHc2u87J9jofdz148hU4l38
	yr2XBIAiGGOX79+JDKMQMf6j+rP836625SO32Y6EaR64rGOn/KuI2SzVVEp463To6/kk8XIoa2r
	N6cE8Pw5aYEsBPp8oxczBllZDxMqdPxPyUyPG5SAT4uOyK6BenYxEnqEsylQFrvBGFKZqtmgo9z
	2yjO9vw2mUiO18UMp6c=
X-Received: by 2002:a05:600c:3549:b0:488:8bdd:cfcc with SMTP id
 5b1f17b1804b1-48a980fc640mr46986015e9.0.1777727197324; Sat, 02 May 2026
 06:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ramon Fried <rfried.dev@gmail.com>
Date: Sat, 2 May 2026 16:06:25 +0300
X-Gm-Features: AVHnY4J_MHB3jchVkS2UGNk1x4VlT2IXZlQ7a578KwyAL9ECPkPmnwx7JWJ_iXM
Message-ID: <CAGi-RUJgnKs5fuu592J0g+VmRdaYBUA2DUern_=t_y+CzG0OSg@mail.gmail.com>
Subject: unsubscribe
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0782D4B215A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10205-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rfrieddev@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



