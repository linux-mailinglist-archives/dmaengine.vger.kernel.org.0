Return-Path: <dmaengine+bounces-9780-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADjuOJDYy2kaMAYAu9opvQ
	(envelope-from <dmaengine+bounces-9780-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:22:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BAD36ADC4
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E80831067BA
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 14:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4733DFC76;
	Tue, 31 Mar 2026 14:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJjvZzK+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B+lFHiwA"
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA63FA5D9
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966610; cv=none; b=AIRxnBeHzLLu9Of6XUH+8grXQWxHRPz5Z+xtHdzlQ2S8Fb2fHQgw/3GksUQMTtN1xSIBn4tDRuQdtqyTMTNFEqPIXM97taEI/Dx5mHApGX7tO3HRdXZag3pwJ8AxoaAGcEcV7cxWapETemWlBO2X/iNV+QNO6FDkbg4ZNTVbaT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966610; c=relaxed/simple;
	bh=5Iw9URBB2+huCGNNmJnyie/vcU11kN7G+C2oBsp0qj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw564K1YOamjxg2tQltI+rp3M8XGvkShC85MQfI995JUmcU2k5BWQrG7wNZWMn+kj6a7gQxVvJNRoEtPJOL9rYl5sRzLLc41/rYRgfr/TVSdd3ovJvD0OPtlJUZSUUgJrOGa6sZmSx0OJUs+JJ2LM7bwZAD48PY1r3Cymoxuo4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CJjvZzK+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B+lFHiwA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774966606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+cvItjsGlgO+YKuRpumctJ3y5xeOoIq89E46KdlSIjg=;
	b=CJjvZzK+sWuY+fgBbqyrjx8+cQtOp15B2H4koVxuc5ZNuxIcBjWAYDCAO7etEYC63rMix/
	053FS2EGL+/2yaWqVAQov26htbN70CpDB64TVw55nrgSLFNtQ1fXNQ2EUmaPDNpO9EAmh5
	WOD7xnx34d/bON1yuS4sJLeOcO8Zo+c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-KFYKxBuTO6yC3DmTWQ-6NA-1; Tue, 31 Mar 2026 10:16:45 -0400
X-MC-Unique: KFYKxBuTO6yC3DmTWQ-6NA-1
X-Mimecast-MFC-AGG-ID: KFYKxBuTO6yC3DmTWQ-6NA_1774966605
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-509044f54aaso181820191cf.1
        for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774966604; x=1775571404; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cvItjsGlgO+YKuRpumctJ3y5xeOoIq89E46KdlSIjg=;
        b=B+lFHiwAOxGHT67wAKheWt/RTxx/O0LwK53PsBQuKG4xl/loLQNWQltBPGY+jnX/C1
         UrvJGJ16BW3ZEF26X9ccZVWOBut15K+qh5cQu+23o9OxyYZ4TmhaicEUA3Z5a9OXvHZT
         uQllq07OgNuwF62joCKEFBKqfqavQ0NeOSL51wBWSsza4JQWJkF6iBitJOjpSkaaFtLQ
         MSL8argPQWqhkG+9vU4OMSDvGCxOg/BTe2X/xZZ8j9+8o9OxpGk0QkiU1Exed8JDJoOZ
         BJxFmh3X7qDqz6+Qi9uI3WIqq5GztjiaOfL4Hb2wb52lm3PdPWPUTHrrsktP6TSklizf
         D0Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774966604; x=1775571404;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cvItjsGlgO+YKuRpumctJ3y5xeOoIq89E46KdlSIjg=;
        b=lLYtm9AOHMXt+Qi+zp8bJyFaYs5vATXi0S3z5nVzYSTkz0VnirFXELJBJtca9+qMah
         Ob084YFhgvrKSVtoXYtjNjkoh43dK7TmdJZ/GcwyuIDhj+A4UsqUTq4cieEG/3Dfupyk
         LlfJz3Uezyb+XECvnoQBy7Qv52l7jT119z7oul9VEiARfO7hSvWjFnUl8SLizsZ4iSn+
         zG3/NacDlZ2zOkkqqlKulqDbprV7rrZpmZ1AGBeVZOuslZBguiqIg/qv70ee5CoSs5JX
         FEsA8PWXIsu7D0x7eiYX1g+WSg7zH8HfDzPwR1qbk3f9PJRkLy9tvyA0Z+Xlnc4sIJsP
         Rq+g==
X-Forwarded-Encrypted: i=1; AJvYcCXT1EpEGE7iJlGP2rpNVBkdrChgzmqEcEQW1JhgA8upRbgg0ldQsKKRYqqRIK8Q+xfz4AaRcAAkyzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2ucazl0OMBAqN/kSXLGppyMcBQg/HrJR7ZrSvyzVtNOhKun3o
	T9pCBMvAjZW+yKiFmCVGVNU/1WuiWrsBXrxLFna6wn/MEFvRPGvQwXm6TX+U8je4sR9/b57Ce2z
	Xvy1kSVg5d9vK1QTFf4UuJnYHPTs9xUjbEm09uLvvGXu0DfsU4a4/qSi211WxpA==
X-Gm-Gg: ATEYQzwDdPmSqatpaF7yGAlgBiBIr76y24B7iiIIbIC0AzKl4ACaNuhawGgXNVj55A8
	pAvy/ndA9OhFVW5DV10JM5OyCmKEaxRI2wogQ70gL9VNy5yqRAZmWZSDeChcJNfcUfWoMcY8pKb
	Bl6cAc+dWZ8dMilcCMO68qpwlg4CQKWU08yP/R/4PRcqjNBraChT1XXUPVbmyPNy1okTuFDbNTY
	Tte+ljUlyNqzjP6hWEqtMsGidnO1z2JGKCpmSshv2Xs/OKZq5MTH1ghF5By32EAVmfbKmhpYX2I
	Q6d0tAOmqjEAW/AyNxU/2btq+JUFo71cSWvy5UELpmKXbU7EbY61GNSm+hG6bCPZMd7eiQwFG5r
	kwfDZDMhD4a8+0bn1
X-Received: by 2002:a05:622a:5e16:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50ba3816a05mr227957601cf.17.1774966604498;
        Tue, 31 Mar 2026 07:16:44 -0700 (PDT)
X-Received: by 2002:a05:622a:5e16:b0:50b:51a0:f744 with SMTP id d75a77b69052e-50ba3816a05mr227957191cf.17.1774966603971;
        Tue, 31 Mar 2026 07:16:43 -0700 (PDT)
Received: from redhat.com ([96.66.166.93])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50bb2c67fefsm86643111cf.4.2026.03.31.07.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 07:16:43 -0700 (PDT)
Date: Tue, 31 Mar 2026 10:16:41 -0400
From: Brian Masney <bmasney@redhat.com>
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>,
	Guodong Xu <guodong@riscstar.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 4/5] clk: spacemit: k3: mark top_dclk as
 CLK_IS_CRITICAL
Message-ID: <acvXSXNWIEcDUpQ3@redhat.com>
References: <20260331-k3-pdma-v3-0-a4e60dd8b4b3@linux.spacemit.com>
 <20260331-k3-pdma-v3-4-a4e60dd8b4b3@linux.spacemit.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331-k3-pdma-v3-4-a4e60dd8b4b3@linux.spacemit.com>
User-Agent: Mutt/2.3.0 (2026-01-25)
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9780-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72BAD36ADC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:27:07PM +0800, Troy Mitchell wrote:
> top_dclk is the DDR bus clock. If it is gated by clk_disable_unused,
> all memory-mapped bus transactions cease to function, causing DMA
> engines to hang and general system instability.
> 
> Mark it CLK_IS_CRITICAL so the CCF never gates it during the
> unused clock sweep.
> 
> Fixes: e371a77255b8 ("clk: spacemit: k3: add the clock tree")
> Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>

Reviewed-by: Brian Masney <bmasney@redhat.com>


