Return-Path: <dmaengine+bounces-2355-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE3905314
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2024 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 981632861FF
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2024 12:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45931176AA8;
	Wed, 12 Jun 2024 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gtnv+UTA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9AC16FF4B
	for <dmaengine@vger.kernel.org>; Wed, 12 Jun 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718197085; cv=none; b=HSE4sXbjTcTADfpnvGXuFHNfce0lqJ2pAafbFLvGqLl09rI05e+elydQKzyGWHSlHs2i3qg29qy/Ol272FZ+czRp+gBDl6httv2KKFYuEuOrWOlg8TmbaAO3/jW+Lh5rY9OOaBaGwp8IOQbAKk+93Bjb8qU3GQTfsY414oAvzuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718197085; c=relaxed/simple;
	bh=MSIXF/BsX8Ykva/XEJfnvjZhA/5dwBPhZQ47OLBzzns=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F/8pXHvR+sQLyQEjL2MvcxZvsYkzw8m9oWyqgAv+Ay2wrJKVREtiqycLkrQem7IzHofieWux6VYAssJIJFPN58L4UK0U2mUx/o0oRKmbi5qAhsf8FhvZLeW4Wx4PW5Y8OxmkJ1xPBUR5N/99LOjxd6Ne3hq1TGLKTRLC4wV4x7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gtnv+UTA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-421bb51d81aso17181245e9.3
        for <dmaengine@vger.kernel.org>; Wed, 12 Jun 2024 05:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718197081; x=1718801881; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W48CiOUHVyxbdD27lMfcp1boY0Sj+/omwPyV/dCaGgM=;
        b=Gtnv+UTALhsZabBEET81PhP4tD9nHPxdigR70niB0PK+1uh39v7kudgws/FfhK1kzG
         KwuTyQtGJ6CWiZi0E/TR+c5fSOymlTFLh6alctfRD9IS0qAD/sjCv0X7Dl1Qqs0Hm9Tr
         kU6DNNeXsHe7133O4HnCZjj6hobjPTy20DgCpbzpjC9f0mN54O0nIOExMAY/I2QVfRKG
         0c6sJ/5UVjgSKLzG/mFE8CxANldDed8gvgjTf/qEJWK41saKcmlm0o4wkmwLPjyfnErX
         sarOYmTP7Jxt+dMsyviPk973rM6qF8VdLD8c5tqjbeir+xJmy6LfCLnw8YACnDzC2ZfV
         eYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718197082; x=1718801882;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W48CiOUHVyxbdD27lMfcp1boY0Sj+/omwPyV/dCaGgM=;
        b=Afam8MjeBv5rjFYv/CYD3RjDJc23/2FO7HK/WEeyu1IffCCT0fGcKJ7US3eQ1oJAIy
         Jf7EjGZQdMb2GNMn4BTnA7VbtsoeD13uoXxabj0yCt+HOUIenStJmqovleU0eOpvL2AT
         sjP+K8Z/YpFqnLb3EyqMWvm+XfTwtIfq2Pzf18FCxtWc93gYGap/Co/PNH5KtIQ/duVB
         bMD8EXLdZqpdvwm7Ei7Z6WjEAEfXyildsKkD4CHFeDrJXtiMeODwdMBFtrbsBkkvacXU
         FLrlfp9bXRGwN1uKun7r5G18exolx7Tb4ue100E06+44OTocQY/c75EohjkrNDo+FXDw
         ykzA==
X-Gm-Message-State: AOJu0Yzh9xBFJIJQ1WxqSwYkDVnQgZmXrv4ao0ct/INuULGZ9QMnu1Xu
	PC7PKetLzU6GhWGg7g8KTQ+zQaUEojud/qRJxspwMpzYylQUk8t/6jwt/EQ12Ik=
X-Google-Smtp-Source: AGHT+IEgFTHa8oy2T4rtWm6BAe6Ym3ELb9M9jJ5tE6NQuUHRFpwf0obrLG0ROdh3kP7+Zy3sSqKVAg==
X-Received: by 2002:a05:600c:3848:b0:422:4c42:f804 with SMTP id 5b1f17b1804b1-422862a71dbmr16826145e9.10.1718197081432;
        Wed, 12 Jun 2024 05:58:01 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870ebb57sm26361765e9.25.2024.06.12.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 05:58:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 15:57:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Subject: [bug report] Merge branch 'fixes' into next
Message-ID: <667b69f3-241e-45f7-965c-9bf50945560b@moroto.mountain>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Vinod Koul,

Commit 5cb664fbeba0 ("Merge branch 'fixes' into next") from Jan 5,
2022 (linux-next), leads to the following Smatch static checker
warning:

	drivers/dma/idxd/submit.c:141 llist_abort_desc()
	error: we previously assumed 'found' could be null (see line 129)

drivers/dma/idxd/submit.c
    97 static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
    98                              struct idxd_desc *desc)
    99 {
    100         struct idxd_desc *d, *t, *found = NULL;
    101         struct llist_node *head;
    102         LIST_HEAD(flist);
    103 
    104         desc->completion->status = IDXD_COMP_DESC_ABORT;
    105         /*
    106          * Grab the list lock so it will block the irq thread handler. This allows the
    107          * abort code to locate the descriptor need to be aborted.
    108          */
    109         spin_lock(&ie->list_lock);
    110         head = llist_del_all(&ie->pending_llist);
    111         if (head) {
    112                 llist_for_each_entry_safe(d, t, head, llnode) {
    113                         if (d == desc) {
    114                                 found = desc;
    115                                 continue;
    116                         }
    117 
    118                         if (d->completion->status)
    119                                 list_add_tail(&d->list, &flist);

Items added to flist here.

    120                         else
    121                                 list_add_tail(&d->list, &ie->work_list);
    122                 }
    123         }
    124 
    125         if (!found)
    126                 found = list_abort_desc(wq, ie, desc);
    127         spin_unlock(&ie->list_lock);
    128 
    129         if (found)

This code assumes found can be NULL

    130                 idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false,
    131                                       NULL, NULL);
    132 
    133         /*
    134          * completing the descriptor will return desc to allocator and
    135          * the desc can be acquired by a different process and the
    136          * desc->list can be modified.  Delete desc from list so the
    137          * list trasversing does not get corrupted by the other process.
    138          */
    139         list_for_each_entry_safe(d, t, &flist, list) {
    140                 list_del_init(&d->list);
--> 141                 idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, true,
                                              ^^^^^
NULL dereference if flist isn't empty but found is NULL

    142                                       NULL, NULL);
    143         }
    144 }

regards,
dan carpenter

