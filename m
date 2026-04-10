Return-Path: <dmaengine+bounces-9954-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHwKErDM2GktiQgAu9opvQ
	(envelope-from <dmaengine+bounces-9954-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 12:10:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1F33D5739
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 12:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40CE830054C7
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 10:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB8F342510;
	Fri, 10 Apr 2026 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcg6k4ee"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDC333F384
	for <dmaengine@vger.kernel.org>; Fri, 10 Apr 2026 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815851; cv=none; b=DA1GkN0ru0mmdgDqSfzdSW86vkwQ9N447utg3jY0kgF7vvJJMFFIm6hHm+WUC40U554D85WD+RMM4PhHRqA3dePN/e7UVSseXxYTFUWm7QllfNf74/haujEpRgKXvFwErEPd7bCcm3s1aCxjNXpFN5pqkDlE1nzSWZJ4cmzizOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815851; c=relaxed/simple;
	bh=SdSrgLE+5WIvB5BGRs6SyNQEEjN1WOUv1tMenNZfFjU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KIUah6ORHrkYMiVlbyqVUk0AeHZZEOcMoXhUWX7gg0eWE0kSHssRHM0xKCGuAamykiA/6mkB6xnD/W1K5XAfIIfLM4F9FrJUwW6KF16qeMZMYNn+ZR521m3V4+/EPXsBNZIXZtl0wGYxmm0TprtiUE2sUcgpCNhAegt/x9beGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcg6k4ee; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so1373529f8f.1
        for <dmaengine@vger.kernel.org>; Fri, 10 Apr 2026 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815848; x=1776420648; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FAWsX5I22/k6R377w4lt12dHitc8pxQocM3PJgMa0o=;
        b=qcg6k4eeeaKz0Ai9YQhtxk6HyuTwk9iAz5BcsPdODlHdxQK31W8Tp3smcjcRqaKEPN
         6TCJdKEoevJE/99SWora1IUVkOii6Y6DSyTzsJRd0wm3d8o0IOmYmTLwmtID8Q2yr3rb
         y+/ofrxDQfRTm9xIFAVWj3zQH3pHPokFNdHx/3Xw62WU+HabNTGdHzFCeHz8BBZWXilt
         c1YNJVzTUpBFhfzGtQzDQ3vEc1emgIFU1xUoJJkhPthoDY/TnfU0oEpaanLIzmlxbavz
         NWiymmXx20IPq5yMYO+n0VNsE7odSOI9Xiuv865WLoT2A2GUji7N02AKE4/GihBSr/pC
         DJiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815848; x=1776420648;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FAWsX5I22/k6R377w4lt12dHitc8pxQocM3PJgMa0o=;
        b=rUBWCPgCJx2qbZQ3ODVmtNm0UVatRxaE+j+anOmAG+nWQNwXPVgejqM/2Tbbtd9XQI
         NwBNqlLYAXFXJw8GelMiZAZG9Zh5wX7geKkvQ/MhcIdiJ3Yi4EfUPf+3pfevFYLUnChQ
         ZKuUfWtr3QJKAtq2fGCC5R1NpsLuNB+LD637idA+0+RXs8ZUsYlZXqCyM9uaAXm369jh
         dusGt1XhUAD+iw/kFYdorF37SPEVN09vmCUa+hWcMX+R9L2S573Mz/hWnYsbzSne07J7
         JnoqqLgruEHDks+QUOrzzDKazax1LrnXoCeDjMlkKaA6ACS34J2mJbKa6MGgq8XOCafO
         XwmQ==
X-Gm-Message-State: AOJu0YxWBaSlUsY7ev2+SUxLT1b24i40tCUCM0NqeJxVPXWIkw6xhnSX
	ZnebMrj4H2oQH9Aspj0eQjRrQhhY8YYm0BHqTAz8/vQXjqWwypdumAg6MtiDLA==
X-Gm-Gg: AeBDieudeI1SPlIaFDD9Cjovp5CKXAuZDxMfyb0yUlMQp4aegnuEo8O+hGSzBrXc2aq
	i6ZoHlTnSFD5NM67wD649apvWjiwOqADplBzwhzGb2L305knw7FdTqLU9AcjUD1sRv4xoOZ+G+w
	u9AylFgYwxoFVwplmjmI3p5IzPSW1D8O6wJKiRRYU01baB3SKxtboVKFjnfTD/a/tC1soP48Ct7
	vq0UZHLoAt4Qm4QzpaqRrm6C4PhosWyeGYOAW1R3bZLQE6qh5k/egN/laEiTAP8B1dQFP5DpMCS
	RN/sJzbrWRJD3owaYP5TxAZquNAMyvDFBTSvmAD2DyF+gdVC5EFIkRjh2P8gKfjkoHrohnPqjo1
	4YxpuxXFGiU64lMxOxvPJW6UUXkT9Peyh6JlIrn+Sg9Au9Ct0F0h7DctLJT2yfbrWYH57f5MEfz
	L41RI52va8GQ+JkD4uzjk=
X-Received: by 2002:a05:6000:24c2:b0:43c:ff58:35c3 with SMTP id ffacd0b85a97d-43d64294ba3mr3628432f8f.10.1775815847862;
        Fri, 10 Apr 2026 03:10:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63deba9esm6712659f8f.10.2026.04.10.03.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:10:47 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:10:44 +0300
From: Dan Carpenter <error27@gmail.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <adjMpFUpBwnsA9kv@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9954-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA1F33D5739
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Binbin Zhou,

Commit 1c0028e725f1 ("dmaengine: loongson: New driver for the
Loongson Multi-Channel DMA controller") from Mar 7, 2026
(linux-next), leads to the following Smatch static checker warning:

	drivers/dma/loongson/loongson2-apb-cmc-dma.c:677 loongson2_cmc_dma_probe()
	warn: unsigned 'lchan->irq' is never less than zero.

drivers/dma/loongson/loongson2-apb-cmc-dma.c
    669         ret = dmaenginem_async_device_register(ddev);
    670         if (ret)
    671                 return dev_err_probe(dev, ret, "Failed to register DMA engine device.\n");
    672 
    673         for (i = 0; i < nr_chans; i++) {
    674                 lchan = &lddev->chan[i];
    675 
    676                 lchan->irq = platform_get_irq(pdev, i);
--> 677                 if (lchan->irq < 0)

lchan->irq is unsigned so the error checking doesn't work

    678                         return lchan->irq;
    679 
    680                 ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
    681                                        dev_name(chan2dev(lchan)), lchan);
    682                 if (ret)
    683                         return ret;
    684         }
    685 
    686         ret = loongson2_cmc_dma_acpi_controller_register(lddev);
    687         if (ret)
    688                 return dev_err_probe(dev, ret, "Failed to register dma controller with ACPI.\n");
    689 
    690         ret = loongson2_cmc_dma_of_controller_register(lddev);
    691         if (ret)

This email is a free service from the Smatch-CI project [smatch.sf.net].

regards,
dan carpenter

