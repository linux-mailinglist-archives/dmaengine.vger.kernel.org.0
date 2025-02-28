Return-Path: <dmaengine+bounces-4622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CCA4A500
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 22:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791DD189ACF0
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 21:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A8923F370;
	Fri, 28 Feb 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b="EUww/kWx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FA91D61B9
	for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 21:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740777808; cv=none; b=QcIXlLWa3kLR30MhuKYFcUyIXjQX8oyQrsoNLM/QENumIMPf0BkkywS6WuUjtSrkomLdXHQI0iDOVItmzyNZI5UKz9H4WfIzxfDRHwm48kCK+peoSjQhXBmwKtrDeDRa7DRLeMxuxXyFV/x7CTzyauzCOJhjqoUCbHfBeGlMEho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740777808; c=relaxed/simple;
	bh=LUAXVwze0ThR1cN48EfTHnYRD5UPpgNJeauAByjnZpw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NZKH32ZgW1K/deV8vhfM6AYHGQwjAoOWngwWE75wuDSxJJlJFpKpA3ACd7c6nkEHYCLTY6tLP6/L3+GxKpRXGrKdIoDDim5Q6BpjBJEwp+ZVeTQ4x/jtC/rGrZY+6olvpsm/i/LBDPxvDXTXloJmpMFAM1RG8/Eo1BeAzQFFPBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar; spf=pass smtp.mailfrom=unc.edu.ar; dkim=pass (1024-bit key) header.d=unc.edu.ar header.i=@unc.edu.ar header.b=EUww/kWx; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=unc.edu.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unc.edu.ar
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5209437e773so1168185e0c.3
        for <dmaengine@vger.kernel.org>; Fri, 28 Feb 2025 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unc.edu.ar; s=google; t=1740777804; x=1741382604; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r5Lndbvf6jvR4u4j/whL554mwxMdmt0r4Qr1dSrHKPc=;
        b=EUww/kWxGCvKs3dF/EEKJo8xgDQHX738opdWmMD5TssYaOoxCqBX4WpxFrjz45BDC/
         quzNH4qLIZibU+Dp4HjhUkEbfBUEiQ7WxwKyDos2EPXetM6gIgc73M24G/2nEtrnm4a/
         qKgGqdQzNSJObYq6NKt3GPyMVpMdViUicceGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740777804; x=1741382604;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r5Lndbvf6jvR4u4j/whL554mwxMdmt0r4Qr1dSrHKPc=;
        b=OPwULz+0S0x53oBq0UXwKnmdqaDoVJDenPXy2B2UzttDgLm+NzT1EMjmVK4jYZLHVn
         Zo51CX39UFa0Xezhh/RBfW2mm3pnbpDl6uYy8vwg1rHXZBz/Oknhy6DaBMJlDNvc1SWK
         gl/8irOnnR4ZsbkQCXW2sm/1OhLT3RVpYAO6TyMLpdICmZvAKsJGzshAUVUjOE78PwyK
         ezDcIPwdnwtS3kA70JftnN+REgikA36rnEbk/ULMtK4gZwz7QBmnh7PnVBlsRlnPKE3k
         mmBQglg+0xs37gKioVAyGyAwCP+Z9AFWL2BjrkLEv9UKWwAINSzqSOYhjpMbUI234uqA
         5IbQ==
X-Gm-Message-State: AOJu0Yzbv4dyNyhOoqPqpdKx0uVEjFqG/DTOwwpKmhm18jfSg2pQjn55
	BG30bZC23rCxoFB7A3NCInoSiErgkSqvXJEaJjEaV6ui6WzBuzubjtt5caJI57Ba1dX5kIYlq9Y
	xgPIEB1We8UxhqOo74/NMDl2XBAaFvmt1vj8IOqHC3vzN2INAG9c=
X-Gm-Gg: ASbGncs9YoASpowUlKrmNSgR12ZbTDZhmJUEDbcT26kGoLoiEJpdKfPrAL8x9l3qShg
	lGg1dH8XDRzrvALXnaXqpRCV6JuSCo0zvHpNOu/WCYr5mbOYxLMz/SB94fHdtH+g4YlQXc+GZZE
	SEbLo4Bqy4ej1E7ooSrCft5z1B6xHINxa05YN4Lwd7sw==
X-Google-Smtp-Source: AGHT+IGHD67rRvzdjUlTSZeDEgZZMAF1mVMWGMPDv8eyvXuZ42BLAXP8ZWiiHvX0Z7ck7r0REXdXtiXXGsP+sXIDNKU=
X-Received: by 2002:a05:6102:32d2:b0:4bc:de7e:4153 with SMTP id
 ada2fe7eead31-4c0449c78b4mr4838464137.3.1740777804123; Fri, 28 Feb 2025
 13:23:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Carlos Sergio Bederian <carlos.bederian@unc.edu.ar>
Date: Fri, 28 Feb 2025 18:23:13 -0300
X-Gm-Features: AQ5f1JqzP44yNrEaHfDQv9BuOGVYXTQB27U-tXju80HzeKpOVdGjiAGyLPrfgW8
Message-ID: <CAFRNPix2JH2De8Hjxwi7EiBnyUVkMvKw7KeowV+EGvd_SuxrfA@mail.gmail.com>
Subject: dma_find_channel(DMA_MEMCPY) on ioat
To: dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I work at an HPC center and I've been trying to figure out why the
knem intra-node communication kernel module stopped being able to use
IOAT to offload memcpy at some point in time, presumably a long time
ago.
The knem module uses dma_find_channel(DMA_MEMCPY) to get a dma_chan so
I wrote a test kernel module that tries to grab a dma_chan using both
dma_find_channel and dma_request_channel and then submits a memcpy.
dma_request_channel succeeds in returning a DMA_MEMCPY channel, but
dma_find_channel never does, regardless of order. This is on a Debian
6.12.9 kernel.
Is there anything I'm missing?

static struct dma_chan* dma_req(void) {
    struct dma_chan* chan = NULL;
    dma_cap_mask_t mask;
    dma_cap_zero(mask);
    dma_cap_set(DMA_MEMCPY, mask);
    chan = dma_request_channel(mask, NULL, NULL);
    if (!chan) {
        pr_err("dmacopy: dma_request_channel didn't return a channel");
    } else {
        pr_info("dmacopy: dma_request_channel succeeded");
    }
    return chan;
}

static struct dma_chan* dma_find(void) {
    struct dma_chan* chan = NULL;
    dmaengine_get();
    chan = dma_find_channel(DMA_MEMCPY);
    if (!chan) {
        pr_err("dmacopy: dma_find_channel didn't return a channel");
        dmaengine_put();
    } else {
        pr_info("dmacopy: dma_find_channel succeeded");
    }
    return chan;
}

