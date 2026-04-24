Return-Path: <dmaengine+bounces-10099-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PCMKz0h62k9IwAAu9opvQ
	(envelope-from <dmaengine+bounces-10099-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 09:52:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A945AF27
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 09:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FBD03019053
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 07:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885822E7621;
	Fri, 24 Apr 2026 07:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do3JL7/Q"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473CF17D6
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017117; cv=pass; b=SsAWHbAaakxsim1QGt3VuN9YyxDE0cgDzwX4kbLCZphrFj+tiXfSaaIOTmSsH6hMKg9CWCfCSw9G60CAg4/QA5ezDaa1RFmfYe0ywA+uFoa+HZHKhxmJF+g3UWKUSw57Vj3q8yYrh5yGlaEDXPArgXVaeCVqc7lNC/d9AgtJplc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017117; c=relaxed/simple;
	bh=lFsRS2y22oj+17OLLlW8LTGu0OQYP4oSY0ggjZms/GE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Hx+/OInrWAU7U1MsHI0hkgHgEtzlbHeOvPN5hYjYJ4x2eGYBAefMj4eVDQuJiNYbV7SrRknbsVCD4IfUkvu/i634Q1yCoB6cOXmATnfKA/81GKyxSIuIqsBSd01YmYBFTUENuZtCpJW13Xl53247Wsh+2AFnD/xAboZzXyw0YDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do3JL7/Q; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79a46ebe2beso77362647b3.2
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 00:51:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777017115; cv=none;
        d=google.com; s=arc-20240605;
        b=fyPvmuZc0lj7Mt3aJfPD9TnH/3s/FAJYPyzsD46sS+QAuTS/xMKQC7dFyKFdyu5dSz
         2nDI2AkZkWcuc/uFwmQ2KWs8qKfTWJLRUWUbeGYpZET1z9lY38UiKY4SKUjS9N2XcF49
         TuFUkuP52o2vkl5jE6qIwNyczel3seSZ3C9b2+X0t4EWt2bAXbnllra6SctGo6g0NlHQ
         pVA5mcOp9HTuRsfZCGjMUNlK2oKfPrvu3K4O75wNtkhbMWXdzEHn0jF8bg3TDTVgcZst
         ByNo4bHXbtJFNKPbH1zUBUjT6v3DobXS8IWPlsQq8jDPtayGkywqTzPm6Pfn6bDnEx/h
         tIiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=7HdzUjmlSmpm1fEEe6ba/AyIS/0BYX2RlUVdee+fk/E=;
        fh=CeXSRbMUJh/lLwdFylBtySBDuhQZKZILMovbKGSOMZg=;
        b=XA/lXt2nxFsaSR5aPOVVfaXkOA5b8pDlpjgw5XXZNUliW7keBmy5PiwuHZjEZSwY1e
         Ufy9az4cuO0ZbhRMvzWKX10MTWVE51HdofFNqHthID1xSIJYOqFFlg6oWZyKkMYUbS3c
         cCjjxLiZ5aInU6ioLDmyM1MRgypjkjqrgw3F++D4D+FiyEs942cHXFEim5GXAoIlCmlG
         a6KYuyMx1mUKFM6Uf3TJASPoQqT1C7fzfnGVkOLbs83yGIokm4ATZf2LD8c4V73xXNh5
         CsaovWuAqHd8oC7Hzq7Yu3refP963RaqcEji0mfG9yj/8FGyN7iSob0L8bxFO5lfe8Ah
         ZhTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777017115; x=1777621915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HdzUjmlSmpm1fEEe6ba/AyIS/0BYX2RlUVdee+fk/E=;
        b=Do3JL7/Qzmh16hkPpYayV+aGoEUxFbDYhRNIMS4OVuJ8Ip91vcfqiOnxsTrr55d0JE
         fhG5mGJYm1cnrp5BNAJ9pNxV0bRYrx89Z2/kTwOqoSIAx59iOseUKee7bu50gHqdSI6r
         EZaux9kuq33OyAqI1UxoyzOvVYlHV7gQ2sR62UYRr2q12lqQ3Mdz4btwOiQZi+oyc1Kn
         iGpj4pQqUmJde98rhKORCOE5NJwk7V/JGmeyAGWzggmr+0Hwr0n7Td+IusUtmoXSrGB0
         iGE4yKi5qkgZ0g25Wby1KHLmMHn7i5GAmnnpA/Mcy8fO6APzoR1vmfQlAUKfEO+ESMZb
         a2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017115; x=1777621915;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7HdzUjmlSmpm1fEEe6ba/AyIS/0BYX2RlUVdee+fk/E=;
        b=R7pJ4SB2FmMgW+198r9G/BPWiaLQqcryelHqDl9Ji6D0l+M/mkKqFMyU6M33/YVqpG
         pv5hVdKusd1/y/mFHCdj3gXZMCDU7Raawg6nIB4lQBUKAZwhTQ9/M+YofQn042FAZdej
         26Z2SMlBfDZvKHCRSnvv1oFHA1jnqii5u1fAYpkjUaAu+2/LghVXPxy9dAK7nUnMcIfR
         9lcNlqvbWrUNHTJlpgZsJWaZYgsEWnutILFCjNRH7h4irIAHxMnwgReqOmyv9PH6+x9W
         M/DJEJjpWb2048pkPfTirgI0zsFabLkvMPnv9MztLeVmuDLLCahHaANdHHqQEKytOFf/
         Jwiw==
X-Gm-Message-State: AOJu0YzpI4PoVcNT3jYTOMC/9/CxdLq1EER4YhwMkiNt/jyy+GzDFeRk
	/d/wo/om4Ksie9W2ZQYIfM21oRxNK+JSjKKRpJjfX2Z4BQ2SlNM8qoVbm2mb3dJLzk7ByER+k29
	e5pifrVHG6UT2gnb62/G3XUunL7wD6P8Svjs61Z0=
X-Gm-Gg: AeBDiesWhV0w3o6udPmW/oDtm41cNC3lFVprwTCQQ70xr8b9E5PXpbzjZD2VEFJMclC
	I8xvDKQ6i0cGe1juVJttr4YqNDYxqXV6YU/DI0+WU3EviCoaTdLSpc/FWZQK51rMurlPrckpAHP
	aqcvIflpGvtKamOSVlcNtIXLmlpw+qBwojcM+m+ZxJhyDwbcXojcPT7XDavympw5dQ+/DTfJC5F
	5b4YDcOV1PBiKsxr5r/if/1NwmwVUaklhMle9CddP7n230b5dy0HPyRmoGjtoGHzhOQRnW8ZrsZ
	+z2PaBz/kvL1EllZhIMn
X-Received: by 2002:a05:690c:8d12:b0:79f:7972:f89a with SMTP id
 00721157ae682-7b9ecf8b0f7mr254793637b3.28.1777017115282; Fri, 24 Apr 2026
 00:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 15:51:44 +0800
X-Gm-Features: AQROBzDSjjT6BlRGwlp6ZQuRjH-5AmmsqHgwi54gLoOpjs-02X3pw_yhBYtjWN8
Message-ID: <CAGp+u1bKApeR56QfbQgk8mkSJ0AbfA5N00kY+BWGxE+cKgyhWQ@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in 'drivers/dma/idxd/irq.c',
 between 'idxd_wq_thread()' and 'idxd_int_handle_revoke()'
To: vinicius.gomes@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1D4A945AF27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10099-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gingerjzllee@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/dma/idxd/' subsystem, more specifically, in
'drivers/dma/idxd/irq.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
idxd_wq_thread[t1]
       --> irq_process_work_list
           --> spin_lock(&bgp->lock); [t2]

T1:
idxd_int_handle_revoke
    --> idxd_abort_invalid_int_handle_descs
         --> spin_lock(&ie->list_lock); [t0]

T1 is invoked from the normal process context and does not disable
hardware irqs in acquiring the spin lock. If T0 (i.e., the hard irq
context) occurs after T1 acquires the lock and both happen within the
same CPU, then T0 will not proceed because it cannot hold the spin
lock that has already been possessed by T1, yet T1 cannot proceed
because the hard irq runs disables preempts.

Thank you for your time and consideration.

Best regards,
Ginger

