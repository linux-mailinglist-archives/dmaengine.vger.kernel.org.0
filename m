Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC7ED50A7E
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 14:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfFXMOI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 08:14:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:56542 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbfFXMOI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 24 Jun 2019 08:14:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OC8heL098312;
        Mon, 24 Jun 2019 12:14:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=2pncpQID3zd065oG9MJs6z2tLkTOWSaRkvK4wBC6qHs=;
 b=zJ0AQPvp+ZiUygbQyelbk8yr/wF2R7YrhEu/bhUizvCboProUCfoDQByIURAzEsWegay
 nmyc+WV69irJthf8qadpwK+n7Ofd3SetpgeTF8a3F34VWaYCONxdMCEqwxDIqA6IPN9Z
 P8bUIai4Tzit4ZYxVkZ42Nzrr4tJwOm8WIh5k0bOlNfcN2v7tw7tcgecQh+zL16/CkUO
 Hkc6vvSjX6CPd9krfeDHpwMwNQebvYSbFQfoxQfGrX6QVQj+KMjXwOsZkAXlE+c1Wyw2
 h0GUOHXE9/8RcEFAvxAnstilTJ6idgCIaK/uzQb6xWubFEgpBDUg6kpUYSIfkNrfdFpy aw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brsx28u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:14:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5OCCebh011132;
        Mon, 24 Jun 2019 12:14:04 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t9p6tj490-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Jun 2019 12:14:04 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5OCE30u003396;
        Mon, 24 Jun 2019 12:14:03 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Jun 2019 05:14:02 -0700
Date:   Mon, 24 Jun 2019 15:13:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dragos.bogdan@analog.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: axi-dmac: Add support for interleaved cyclic
 transfers
Message-ID: <20190624121357.GA29335@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=515
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906240101
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9297 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=560 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906240101
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dragos Bogdan,

The patch 8add6cce9848: "dmaengine: axi-dmac: Add support for
interleaved cyclic transfers" from May 16, 2019, leads to the
following static checker warning:

	drivers/dma/dma-axi-dmac.c:666 axi_dmac_prep_interleaved()
	warn: bit shifter 'DMA_CYCLIC' used for logical '&'

drivers/dma/dma-axi-dmac.c
   658          if (chan->hw_2d) {
   659                  desc->sg[0].x_len = xt->sgl[0].size;
   660                  desc->sg[0].y_len = xt->numf;
   661          } else {
   662                  desc->sg[0].x_len = xt->sgl[0].size * xt->numf;
   663                  desc->sg[0].y_len = 1;
   664          }
   665  
   666          if (flags & DMA_CYCLIC)
   667                  desc->cyclic = true;

This won't work.  I think you have to use dma_has_cap() or test_bit() or
something.  Or you could do:

	if (flags & (1 << DMA_CYCLIC)) {

DMA_CYCLIC is 0xb so this will return true for a bunch of stuff when it
shouldn't.

   668  
   669          return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
   670  }


regards,
dan carpenter
