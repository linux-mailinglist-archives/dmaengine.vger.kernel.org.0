Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A575DDB4
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jul 2023 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGVROd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jul 2023 13:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVROc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jul 2023 13:14:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D567E67;
        Sat, 22 Jul 2023 10:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690046071; x=1721582071;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=/NqgA0E24iFKqv6TOSZM3Z4tMvI5XUmHE6RDNtykCIo=;
  b=i6EQxJQ4T2ohQ8ML37NC1saU/Tky9ftlyhPyAS95W8iNQAtZuHHHHFxi
   MSHXRDRkZvcUM+X4agTVIiXQl2Mw0qozCOm53lda6FXFGYAYQvO3P4pe9
   5POCcC6b+We4w92lZgcM4Smk3F4cvwbybLt+YsS9CSB8DhmqUBGqQFqFu
   Ope28M2GFzZ9SyC4b+eDlrdrwR+yjRTi4T5mwIn9PcOAb014vYCLWFtM6
   rTQ7FTs7dYY9bIlu4Iul8uMS8vBdz7bhuhlmYXUq3QOLxQ+iMvHmlHQm2
   nZ8z/3qCuQkiljQCkEeV17uB9K+rrnXheMNRyBp8cnwr1GZcxbXeohifh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="346815030"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="346815030"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 10:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="702386602"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="702386602"
Received: from maggieya-mobl1.amr.corp.intel.com ([10.212.61.70])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 10:14:29 -0700
Message-ID: <6ba5b58f637e3ec8c4b00e407e18dd426db6086f.camel@linux.intel.com>
Subject: Re: [PATCH v7 12/14] crypto: iaa - Add support for deflate-iaa
 compression algorithm
From:   Tom Zanussi <tom.zanussi@linux.intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Date:   Sat, 22 Jul 2023 12:14:28 -0500
In-Reply-To: <ZLsvdS6NbaetDFe1@gondor.apana.org.au>
References: <20230710190654.299639-1-tom.zanussi@linux.intel.com>
         <20230710190654.299639-13-tom.zanussi@linux.intel.com>
         <ZLsvdS6NbaetDFe1@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, 2023-07-22 at 13:23 +1200, Herbert Xu wrote:
> On Mon, Jul 10, 2023 at 02:06:52PM -0500, Tom Zanussi wrote:
> >=20
> > Because the IAA hardware has a 4k history-window limitation, only
> > buffers <=3D 4k, or that have been compressed using a <=3D 4k history
> > window, are technically compliant with the deflate spec, which
> > allows
> > for a window of up to 32k.=C2=A0 Because of this limitation, the IAA
> > fixed
> > mode deflate algorithm is given its own algorithm name, 'deflate-
> > iaa'.
>=20
> So compressed results produced by this can always be decompressed
> by the generic algorithm, right?
>=20

Right.

> If it's only when you decompress that you may encounter failures,
> then I suggest that we still use the same algorithm name, but fall
> back at run-time if the result cannot be decompressed by the
> hardware.=C2=A0 Is it possible to fail gracefully and then retry the
> decompression in this case?
>=20

Yeah, I think that should be possible. I'll try it out and add it to
the next version.  Thanks for the suggestion!

Tom


> Thanks,

