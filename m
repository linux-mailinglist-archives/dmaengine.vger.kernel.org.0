Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFEA468286B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Jan 2023 10:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjAaJOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Jan 2023 04:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjAaJNl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Jan 2023 04:13:41 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1125D4AA74;
        Tue, 31 Jan 2023 01:11:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45722CE1C5C;
        Tue, 31 Jan 2023 09:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF2BC433D2;
        Tue, 31 Jan 2023 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675156248;
        bh=iQ1Xydi1GvEvZNrYB1OdH3nAEKk7nKI4XluwpZQns+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sid16eamf7gs4IwwoHZC7q2+vEJtUJh1LYFWlfoRq+9pXJ0J21KIw4rFun+zC/bkb
         y8QhZv3QWQVeyCsld2iGKhMu+lMtE2tl19JvM817z83O/D4q4TjjKizvIzWu5aVa01
         LCSyV+jltrS5r9p1Tp6h4MpR4zKfldylfZZGNDkQ=
Date:   Tue, 31 Jan 2023 10:10:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/9] Documentation: driver-api: correct spelling
Message-ID: <Y9jbEDPHbBb1hbsZ@kroah.com>
References: <20230129231053.20863-1-rdunlap@infradead.org>
 <20230129231053.20863-3-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129231053.20863-3-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 29, 2023 at 03:10:46PM -0800, Randy Dunlap wrote:
> Correct spelling problems for Documentation/driver-api/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: nvdimm@lists.linux.dev
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> Cc: Song Liu <song@kernel.org>
> Cc: linux-raid@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> ---

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
