Return-Path: <dmaengine+bounces-4708-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0500DA5D6A7
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 07:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A19178219
	for <lists+dmaengine@lfdr.de>; Wed, 12 Mar 2025 06:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23B1E5B67;
	Wed, 12 Mar 2025 06:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIBlAd/H"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6056F1CA9C
	for <dmaengine@vger.kernel.org>; Wed, 12 Mar 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762512; cv=none; b=MvTJhPl5C9ZkHzmrI6G8JiClWjCjosu5NUWt684s68kKVmxZhvlVLzwuK3GJuyDmfz8iIVtu/LRvXA2MA8AaqYsycOmRiQOXNGWffDnLgWdQst8C6HCdZ7aCie+wl4TXAAbas/JFIn4ufINQWoEfYYthgCPbQKMT6BXngQhuWEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762512; c=relaxed/simple;
	bh=T3j/jhwwGaqM/PtiCyFuJmsNs4PNl0s8uQgcrpMkCvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ioee5PNkO0jSgoVVPgxe64HnGTkN4R6LUe2tAEznXXDgTuSG+xhQPLdbb0AdgOPn51ZmpKMAGuF58BxJRp5T5N1InoLzkv4z/L0yPsEqkIa4RHiaqhuDg+Bq8HX4WFOZ2sr3kOZx4iVVTyd7bYEXKiiSnoOL4l9c1rb2Q9MHuYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MIBlAd/H; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-390f5f48eafso3067972f8f.0
        for <dmaengine@vger.kernel.org>; Tue, 11 Mar 2025 23:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741762509; x=1742367309; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L4yZ5zq12j+hRg9Z7RbRtetYYFqf5FaL2kNYT7W7mos=;
        b=MIBlAd/HM9hHKmhzVbl3yMJK9Hiz2XF20NZecChX4v5xME9xaooNwwyjpasE+GhrLV
         +arZ5z4IQQ0sDuQhR7jlOtbbnEt63CjFNhcYK2QoYkeFvSIztuu9bL6lQjigHlp7p3y4
         yrU+EjtXYQUdRL1K06YBStnY2LolMgRYwhneNVZZoIdkOa8xq1ZgO93AstD8UfZ6xk3c
         6T6H209b2V3UhTUw8zvp9bcTAxu5Y18WyXPIdVC7ZBTU8fmBGAv8KeyD856N7rF5tWvJ
         jY2egfdpAkmxhBwkkA9x4MAJXygwSK2om0R6R9cOks31KAwVLMPgex0mlbBFgcd3lU+r
         IHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741762509; x=1742367309;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L4yZ5zq12j+hRg9Z7RbRtetYYFqf5FaL2kNYT7W7mos=;
        b=arpZJKsjDLURfLWrrj0e/jIQzQ/4TMiwac7TlrATreyj54edWRCwypTbCcRHQX99o8
         4DFiJVdTxj0i9XJpRlXSFdUdozwo9rHHrsFes22y71WQ51svHVCB+XpbE068VcToyU8N
         FQd78uTBKy49c5LfwIdq2Wd31ZZ9T8r8nt2Vw4PhX1O6QkK5LzTOA4sflHuIeZhayZ1N
         kZieVMez6ndAxTULkZ207j58qAh71xY4Cs99pJptDEdcl7owXP1dviU7TyDgZ5JxBtgn
         GLMnwfOpx38P6VICT+3INIk/lGz0nnN+zBu7jAlbzaKN3aqj8R9bPLNYp4neG5s5bDMu
         i6mw==
X-Gm-Message-State: AOJu0YyAYkBt9KFIi/f7Ktbg37QA6m8ENpjQbDYE/FpUzD/iOZRC2JHk
	1gm0qYOAaJ7nQbgDA5NBUOy13apXfzSPY+3n0mwcX5DFs0MBKahmMSB1INfjeSQ=
X-Gm-Gg: ASbGnctNhhZDPt8pMQSdnTKaP1xug0tR+VKIEnNCvS5sBpjnxcdmeKSYsDuJGgG77BU
	NocaIUtP9DkpbjAH9rO1+ldsTdpM5I79/Uayl1vdlwDLJEIX+3rrWI5ES9tUF4C/ejDJ6nfMIq1
	G41zW+w6PQ9NN/l4jxOgqyCZrBilYFHmiZ4z0EiJ2y3FAVxjRXYemhf4F8etq2TB8mNafiQyeMl
	IVFEYBYpL3BzXy2cnonecSQD2g9kUOXi0uP/5PrLQmzl7qDNnhxJDBg3DCkby2W/txQ6idLV0Ij
	eRX5XPCbC7KA7Car+mdmE3jekCBk3z6MpBTKVJgR1vrMns0ONA==
X-Google-Smtp-Source: AGHT+IH+FmYIaf/Gu1kG+mOBiTn3P4SWsA1kKuiL1jq5GXhRMxU46FXGYnIMkNLHHZ52ATKqvzWhGg==
X-Received: by 2002:a05:6000:1f8f:b0:390:f6aa:4e80 with SMTP id ffacd0b85a97d-39132de2a58mr18337963f8f.53.1741762508683;
        Tue, 11 Mar 2025 23:55:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d031d0e41sm35109925e9.0.2025.03.11.23.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 23:55:08 -0700 (PDT)
Date: Wed, 12 Mar 2025 09:55:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: ptdma: Utilize the AE4DMA engine's
 multi-queue functionality
Message-ID: <bfa0a979-ce9f-422d-92c3-34921155d048@stanley.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Basavaraj Natikar,

This is a semi-automatic email about new static checker warnings.

Commit 656543989457 ("dmaengine: ptdma: Utilize the AE4DMA engine's
multi-queue functionality") from Feb 3, 2025, leads to the following
Smatch complaint:

    drivers/dma/amd/ptdma/ptdma-dmaengine.c:358 pt_cmd_callback_work()
    warn: variable dereferenced before check 'desc' (see line 345)

drivers/dma/amd/ptdma/ptdma-dmaengine.c
   344	
   345		dma_chan = desc->vd.tx.chan;
                           ^^^^^^
desc is dereferenced

   346		chan = to_pt_chan(dma_chan);
   347	
   348		if (err == -EINPROGRESS)
   349			return;
   350	
   351		tx_desc = &desc->vd.tx;
   352		vd = &desc->vd;
   353	
   354		if (err)
   355			desc->status = DMA_ERROR;
   356	
   357		spin_lock_irqsave(&chan->vc.lock, flags);
   358		if (desc) {
                    ^^^^
So this check is too late.

   359			if (desc->status != DMA_COMPLETE) {
   360				if (desc->status != DMA_ERROR)

regards,
dan carpenter

