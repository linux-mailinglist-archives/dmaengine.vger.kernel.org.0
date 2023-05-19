Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F95708E7B
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 05:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjESD4v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 18 May 2023 23:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjESD4v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 18 May 2023 23:56:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899CCE75;
        Thu, 18 May 2023 20:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gpsz6npDHVFSw1EWEqKvMH8wRk2QP4HwK8Cw+1qxftg=; b=QrpA83FpxqkZP75q4uAA4UsM5i
        ZK5QFdf8ZlDSpIEgizQWJSPkNARkw1w1DcjwBX9Yy2ySEQ65c2IkAA5zMb5aOWPU2/piPiibT9MRI
        QGGfa5Y6f62uV7f8A+tBx4kZK9yw/v4tQEJoHXRn2FKzYjL/xy5NVhbHM1SiFsbvKoQEPVxY4j8qP
        Li5Vi2M1QkgNeI2wsl4JuTnE+6P5Kns3ky7xa6zELqMMD6H0ET0kPklo+tN01WI+vs/qD8tuiqcma
        3hdMRtlUp22l6r+I8PDATLBMefocJNOkHrD/IhSMMwQ/zw6TJQLCT5yP2cqoZxP8MNlFvjsv4tTbo
        OUJmdcuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzrEV-00Ezzp-1K;
        Fri, 19 May 2023 03:56:47 +0000
Date:   Thu, 18 May 2023 20:56:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        george.ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
Subject: Re: [PATCH v5 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZGbzf6G5OpK0mRXN@infradead.org>
References: <20230518165920.897620-1-kelvin.cao@microchip.com>
 <20230518165920.897620-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518165920.897620-2-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

> +/*
> + * Use vender/device and class to identify the DMA function.
> + */
> +#define SWITCHTEC_DMA_DEVICE(device_id) \

I'd word this as:

/*
 * Also use the class code to identify the devices, as some of the
 * device IDs are also used for other devices with other classes by
 * Microsemi.
 */

to emphasis on why this macro even exists.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
