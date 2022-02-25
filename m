Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62034C4A7C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Feb 2022 17:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiBYQVd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Feb 2022 11:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242876AbiBYQVc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Feb 2022 11:21:32 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8336F4B6;
        Fri, 25 Feb 2022 08:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FZ+MIKFcY92n2eEbmV05gJlf+p4zCLQ/l4UmfykudCI=; b=OHdUVHs4ssN+cZff1Cz5+pI0bS
        ACNDnitCkCgOeMfk5gHAdYVGGQ6ME1qo4qkJR7TLTp2sJqfXgC26sejwftaWRuLSQ2QgdEaTHgKcS
        LumBh6cyD5rIHpzntIup3R4VIph/iP/IlDryFo7261s9jLf+pgqyQuTn/+hNcDMQY4jujjArIhda2
        TF4OI8Z1yT7KkgU/aiDktotaDlqJVWouebA4emJYnv0RIB8s5A0kdloko8BGbhBYl2zUpg8dVEWaQ
        +xZrdNzW+wzeWegSUfiXFYR5A0q3GL3p/8ExZszbBLmFxq2xIrxmNwTCzjjZtgaXkpm+Zzz73lf8O
        f+1824/A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNdK8-005sWo-3G; Fri, 25 Feb 2022 16:20:04 +0000
Date:   Fri, 25 Feb 2022 08:20:04 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        davem@davemloft.net, airlied@linux.ie, vkoul@kernel.org,
        hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, awalls@md.metrocast.net, mchehab@kernel.org,
        sathya.prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com, mporter@kernel.crashing.org,
        alex.bou9@gmail.com, bhelgaas@google.com,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-fpga@vger.kernel.org, linux-media@vger.kernel.org,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 00/16] Remove usage of the deprecated "pci-dma-compat.h"
 API
Message-ID: <YhkBtBdBhvCAtNH9@infradead.org>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

I've applied patches 1,5,6,8 and 9 to the dma-mapping tree.
