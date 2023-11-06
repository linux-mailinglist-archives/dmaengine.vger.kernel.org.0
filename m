Return-Path: <dmaengine+bounces-55-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DD27E25E4
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 14:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B03281441
	for <lists+dmaengine@lfdr.de>; Mon,  6 Nov 2023 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0149249E2;
	Mon,  6 Nov 2023 13:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFiq9kxQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3B23777
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 13:44:22 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ADFD8
	for <dmaengine@vger.kernel.org>; Mon,  6 Nov 2023 05:44:20 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso691506766b.1
        for <dmaengine@vger.kernel.org>; Mon, 06 Nov 2023 05:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699278259; x=1699883059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q7e9Ec68Ydmk63OSQsConTxB03oSMTJh6BRkMmt0d9Q=;
        b=CFiq9kxQ6L5v+VEMUaAnW1eP2+D2lSjPOwFh49bcjoukS7WDcwu7d7ZaF8TrZx3GQ2
         VFwc08ajL9hr+R8TwD8eUEzruP0kThul84LT+H8ua0WZeUm12xW1n70hfvvxuO6uBruO
         gL3nvVkVNiGgV5E4MRl4jvttzLv/AqYlW7vvI594AUcIx9caDNNrzJzGPFfMTvJfD8wj
         BtdLRJkK8d/2nDNvtL0xdY1lou39kTbiVenDvdROqw3MuBovCee6NEyFZ5J2TMJed5r7
         8qqRhLirOvTjcNfNIG8fEJuoDXVtgDe44dE/QrSPBDBsG+PporWhuvzgPe9dF7CHqJJZ
         M7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699278259; x=1699883059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7e9Ec68Ydmk63OSQsConTxB03oSMTJh6BRkMmt0d9Q=;
        b=VRkJo56lnSkOmEqwPRDWw1O+iccgi70rQf8psjxWDvl5eRiwNMVrrNEWx6nZxCLQMe
         PfV/BHNmdIeVQZ5m9aqGAQeam3tBqG39bMUxqBfJ9+n+IBLoxpnWUeWDomh2/qPWK2v5
         s8RWC/jVz1aYMHsxTCwMQVJ0XZDC9w0Mj0vDFUeERQ1Q/TPQwiDF9dHb6/AKRPTP3wN2
         UVEVt0M2zz9tgZl8M2KeIsLLMcTuDYrCRPjjpQYhdAvjN6/joXRo1hHyzZflPrm2ksFT
         QfnnuEAl35oJ6bC8OjvujWg9xHV0pPH1I4AuLzBsF5e6AhLtBKUBxaa5Z+I1Fmd8wcb4
         ADhg==
X-Gm-Message-State: AOJu0YwGFdU3UMBCmTEXWjjtZsy02Uz8vIQpgWplZPCJbtI1aQdAcSTp
	ZDwDd9zlp3TXlFNgz4Ex5booaQ==
X-Google-Smtp-Source: AGHT+IHiakzgI6LCjuKf2DUxW4dwg+isgj008eu/G7z8A0PZqUSpMz2yarqnNJAljDV/TJ/7ffeHxQ==
X-Received: by 2002:a17:907:26c9:b0:9e0:dde:cc9f with SMTP id bp9-20020a17090726c900b009e00ddecc9fmr3038620ejc.22.1699278259262;
        Mon, 06 Nov 2023 05:44:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id jw24-20020a17090776b800b0098e78ff1a87sm4144742ejc.120.2023.11.06.05.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 05:44:18 -0800 (PST)
Date: Mon, 6 Nov 2023 16:44:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Wenchao Hao <haowenchao2@huawei.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Douglas Gilbert <dgilbert@interlog.com>, dmaengine@vger.kernel.org,
	linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] scsi: scsi_debug: fix some bugs in
 sdebug_error_write()
Message-ID: <ea7dff5a-3a5d-414d-8a8c-a737c8ec8004@kadam.mountain>
References: <96d50cf7-afec-46af-9d98-08099f8dc76e@moroto.mountain>
 <CAOptpSMTgGwyFkn8o6qAEnUKXh+_mOr8dQKAZUWfM_4QEnxzxw@mail.gmail.com>
 <44b0eca3-57c1-4edd-ab35-c389dc976273@kadam.mountain>
 <cbe14e3a-11c7-4da5-b125-5801244e27f2@gmail.com>
 <9767953c-480d-4ad9-a553-a45ae80c572b@kadam.mountain>
 <afe1eca8-cdf8-612b-867e-4fef50ad423f@huawei.com>
 <9207ed62-4e41-4b8c-8aee-5143c1a71bf8@kadam.mountain>
 <65b8f53d-4956-4440-bd4c-66475015aaff@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65b8f53d-4956-4440-bd4c-66475015aaff@gmail.com>

Oh.  Duh.  The issue is that echo doesn't actually put a NUL terminator
on the end of the string...  Let's go with kzalloc(count + 1, as you
suggest.

regards,
dan carpenter


