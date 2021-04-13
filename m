Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF85B35DCED
	for <lists+dmaengine@lfdr.de>; Tue, 13 Apr 2021 12:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhDMK4i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Apr 2021 06:56:38 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:51460 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhDMK4h (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Apr 2021 06:56:37 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DAtOiI068871;
        Tue, 13 Apr 2021 10:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=9FK21CzWg0WZpbBLLTCNb5AamAJs4+xmyM9gkb5hr5I=;
 b=qX0Jt/PzNzNqxB+v42+mXBvQt40GVgOPjgLy1ia1Y6qudnlH1Qk9A9EmWVKUm3qLkFyG
 1JSbHs1a2gZtDDDqKBvoDsetgu73jv3BHFnnaw4URKuHXtXvyzcqGu2SNqrsoEj+3JCa
 vE+hE7vrnoudxMAjHSFGB3hp97qncJRYD6A52Tok2uOVzT9jA66xbFtCULrN9tzbDYzk
 LgOuVqoZIKJmq73j9VhVT181Jgw6OWsS1cO3jBLhNlgbpatYhmR1zs0/go6nghQi7WEq
 syB8T7R5DYeWFgk16dpkQ7dR+dX/GtPj5Tbqbz0vn61blMoJ71bx4aQPHflmyKcTuMa5 hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 37u1hbes1n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:56:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DApdRc076724;
        Tue, 13 Apr 2021 10:56:15 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 37unwymcv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 10:56:15 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13DAuEEw009667;
        Tue, 13 Apr 2021 10:56:14 GMT
Received: from mwanda (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Apr 2021 03:56:14 -0700
Date:   Tue, 13 Apr 2021 13:56:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org
Subject: [bug report] dmaengine: driver for the iop32x, iop33x, and iop13xx
 raid engines
Message-ID: <YHV4yPcJVyRgphn6@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=905 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130075
X-Proofpoint-GUID: EttomDNdGKfW9kHgO1iLeB6Ws2wMAuNg
X-Proofpoint-ORIG-GUID: EttomDNdGKfW9kHgO1iLeB6Ws2wMAuNg
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=881 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130075
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Dan Williams,

The patch c211092313b9: "dmaengine: driver for the iop32x, iop33x,
and iop13xx raid engines" from Jan 2, 2007, leads to the following
static checker warning:

	drivers/dma/iop-adma.c:1425 iop_adma_probe()
	warn: '&iop_chan->common.device_node' not removed from list

drivers/dma/iop-adma.c
  1377          spin_lock_init(&iop_chan->lock);
  1378          INIT_LIST_HEAD(&iop_chan->chain);
  1379          INIT_LIST_HEAD(&iop_chan->all_slots);
  1380          iop_chan->common.device = dma_dev;
  1381          dma_cookie_init(&iop_chan->common);
  1382          list_add_tail(&iop_chan->common.device_node, &dma_dev->channels);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
We add this to the dma_dev channels list but

  1383  
  1384          if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
  1385                  ret = iop_adma_memcpy_self_test(adev);
  1386                  dev_dbg(&pdev->dev, "memcpy self test returned %d\n", ret);
  1387                  if (ret)
  1388                          goto err_free_iop_chan;

if there is an error

  1389          }
  1390  
  1391          if (dma_has_cap(DMA_XOR, dma_dev->cap_mask)) {
  1392                  ret = iop_adma_xor_val_self_test(adev);
  1393                  dev_dbg(&pdev->dev, "xor self test returned %d\n", ret);
  1394                  if (ret)
  1395                          goto err_free_iop_chan;
  1396          }
  1397  
  1398          if (dma_has_cap(DMA_PQ, dma_dev->cap_mask) &&
  1399              dma_has_cap(DMA_PQ_VAL, dma_dev->cap_mask)) {
  1400                  #ifdef CONFIG_RAID6_PQ
  1401                  ret = iop_adma_pq_zero_sum_self_test(adev);
  1402                  dev_dbg(&pdev->dev, "pq self test returned %d\n", ret);
  1403                  #else
  1404                  /* can not test raid6, so do not publish capability */
  1405                  dma_cap_clear(DMA_PQ, dma_dev->cap_mask);
  1406                  dma_cap_clear(DMA_PQ_VAL, dma_dev->cap_mask);
  1407                  ret = 0;
  1408                  #endif
  1409                  if (ret)
  1410                          goto err_free_iop_chan;
  1411          }
  1412  
  1413          dev_info(&pdev->dev, "Intel(R) IOP: ( %s%s%s%s%s%s)\n",
  1414                   dma_has_cap(DMA_PQ, dma_dev->cap_mask) ? "pq " : "",
  1415                   dma_has_cap(DMA_PQ_VAL, dma_dev->cap_mask) ? "pq_val " : "",
  1416                   dma_has_cap(DMA_XOR, dma_dev->cap_mask) ? "xor " : "",
  1417                   dma_has_cap(DMA_XOR_VAL, dma_dev->cap_mask) ? "xor_val " : "",
  1418                   dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
  1419                   dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
  1420  
  1421          dma_async_device_register(dma_dev);
  1422          goto out;
  1423  
  1424   err_free_iop_chan:
  1425          kfree(iop_chan);

Then there is a freed pointer still on the list leading to a use after
free.

  1426   err_free_dma:
  1427          dma_free_coherent(&adev->pdev->dev, plat_data->pool_size,
  1428                          adev->dma_desc_pool_virt, adev->dma_desc_pool);
  1429   err_free_adev:
  1430          kfree(adev);
  1431   out:
  1432          return ret;
  1433  }

regards,
dan carpenter
